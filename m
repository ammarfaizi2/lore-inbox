Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTENTQc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTENTQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:16:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16140 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261243AbTENTQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:16:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] PAG support, try #2
Date: 14 May 2003 12:28:45 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9u5dd$sg$1@cesium.transmeta.com>
References: <24225.1052909011@warthog.warthog> <Pine.LNX.4.44.0305140924040.3107-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0305140924040.3107-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> And "pag_t" needs to be bigger, at least 64 bits. That, together with the
> "credential == 'list of PAG'" thing means that you can choose to do things
> like:
> 
>  - high bits zero, low bits match the UID (ie all users automatically get 
>    their own "private PAG", PAM just does the joining automatically)
> 
>    I personally _require_ this. End of discussion. Anything that doesn't 
>    allow for user-friendly automatic PAG's is, in my not-so-humble 
>    opinion, a total waste of time, and complete CRAP.
> 
>    Did I make my opinion clear enough? In other words, when I log in, I 
>    want to automatically get certain credentials, and I consider the
>    log-in sequence to be sufficient security for those credentials. 
> 
>    Anything that isn't designed for this is WRONG.
> 
>  - high bits "group pattern", low bits "GUID" - same thing as UID. Some 
>    PAG's are automatically associated with the _group_ ID of the person. 
>    When I log in, and I'm in the "engineering" group, I should
>    automatically get access to the "engineering PAG". 
> 
>  - users can controlledly join other PAGs as they wish (ie if you want to 
>    have credentials that are on top of the automatic user credentials, you
>    have to join them explicitly, which migth require a stronger password
>    or something)
> 
>    This allows for the "extra" credentials, and it also allows for users 
>    joining each others PAG's at least temporarily. It also allows things 
>    like extra groups outside of the traditional scope of groups (ie you 
>    can set up ad-hoc groups by creating a new PAG, and letting others join
>    it).
> 

Sounds like what you really want is capabilities, and not in the
setcap sense.  I think this would be marvellous, myself, and I
completely agree that we need it to be user friendly.

To some degree, groups are also capabilities, but there is too much
rigamarole surrounding them.  I also think evidence has shown that
it's too hard to add or remove group ownership; you basically need the
user to log out completely in order to add or drop the new ownerships.

	-=hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbVITRxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbVITRxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbVITRxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:53:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932734AbVITRxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:53:47 -0400
To: stephen.pollei@gmail.com
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nikita Danilov <nikita@clusterfs.com>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <nikita@clusterfs.com>
	<17197.15183.235861.655720@gargle.gargle.HOWL>
	<200509192316.j8JNFxY8030819@inti.inf.utfsm.cl>
	<feed8cdd0509192057e1aa9e3@mail.gmail.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: Tue, 20 Sep 2005 14:53:00 -0300
In-Reply-To: <feed8cdd0509192057e1aa9e3@mail.gmail.com> (Stephen Pollei's
 message of "Mon, 19 Sep 2005 20:57:20 -0700")
Message-ID: <or4q8fvd6r.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2005, Stephen Pollei <stephen.pollei@gmail.com> wrote:

> On 9/19/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>> Nikita Danilov <nikita@clusterfs.com> wrote:
>> > It's other way around: declaration is guarded by the preprocessor
>> > conditional so that nobody accidentally use znode_is_loaded() outside of
>> > the debugging mode.
>> 
>> Since when has a missing declaration prevented anyone calling a function in
>> C?!
> Never AFAIK... K&R, ANSI,ISO C89,  c99, whatever version that I know of...

Actually...  C99 requires a declaration (not necessarily with a
prototype) before a function can be called.  A prior declaration is
required for all identifiers.  I'm not sure whether this is new in C99
or carried over from ISO C90 (AKA ANSI C89).  The fact that so many
compilers accept calls without prior declarations is a common
extension to the language, mainly for backward compatibility.

> It's really over silly anyway, as it will fail at link time if they
> had matching preprocessor stuff around the function definition.

Not really.  A compiler might optimize away the reference to the
symbol if it's say guarded by a condition whose value can be
determined to be false at compile time.  If you rely on that, moving
to a different compiler that is unable to compute the condition value,
or simply is pickier as to standard compliance, will get you errors.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

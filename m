Return-Path: <linux-kernel-owner+w=401wt.eu-S1947316AbWLHVeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947316AbWLHVeo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947312AbWLHVeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:34:44 -0500
Received: from gw.goop.org ([64.81.55.164]:33031 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947315AbWLHVen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:34:43 -0500
Message-ID: <4579DA6D.1030305@goop.org>
Date: Fri, 08 Dec 2006 13:34:37 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arkadiusz Miskiewicz <arekm@maven.pl>, linux-kernel@vger.kernel.org
Subject: Re: proxy_pda was Re: What was in the x86 merge for .20
References: <200612080401.25746.ak@suse.de> <200612082206.20409.ak@suse.de> <4579D496.6080201@goop.org> <200612082222.33673.ak@suse.de>
In-Reply-To: <200612082222.33673.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The trouble is when it's CSEd it actually causes worse code because
> a register is tied up. That might not be worth the advantage of having it?
>   

I think so, definitely; without proxy_pda you need to make it asm
volatile+mem clobber, which completely eliminates all optimisation
opportunities; in general the proxy_pda allows gcc to CSE and reorder
pda accesses.  I guess in this case the memory writes inhibited the
overall CSE of current, so its just making do by CSEing the address.

> Hmm, maybe marking it volatile would help? Arkadiusz, does the following patch
> help?
>   

Might work.  But doesn't this make the pointed-at proxy_pda volatile,
not the proxy_pda pointer itself?  Should it be something like (volatile
__T * volatile)?

    J

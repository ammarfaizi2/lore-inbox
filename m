Return-Path: <linux-kernel-owner+w=401wt.eu-S1751102AbXACTsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbXACTsi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbXACTsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:48:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:54807 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbXACTsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:48:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D8NIbTJ5KI41DzDWRLoLgFBQPeQtolp6iOqot80H7GfDawYdlCJqS+EcxSmfxFJEgwTebmBVkNK0Q+6o0iZzi3I0xvv6riQVNFCZLATmVDbwRZoRZQh3f2oNDSFL4uUbzwuvEA74wSTINrYjZ1VIWdi/QkXSwI2KKQKMQVi8tRM=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Wed, 3 Jan 2007 20:47:02 +0100
User-Agent: KMail/1.8.2
Cc: Grzegorz Kulewski <kangur@polcom.net>, Alan <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
References: <200701030212.l032CDXe015365@harpo.it.uu.se> <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net> <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701032047.02941.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 January 2007 17:03, Linus Torvalds wrote:
> On Wed, 3 Jan 2007, Grzegorz Kulewski wrote:
> > Could you explain why CMOV is pointless now? Are there any benchmarks proving
> > that?
> 
> CMOV (and, more generically, any "predicated instruction") tends to 
> generally a bad idea on an aggressively out-of-order CPU. It doesn't 
> always have to be horrible, but in practice it is seldom very nice, and 
> (as usual) on the P4 it can be really quite bad.
> 
> On a P4, I think a cmov basically takes 10 cycles.
> 
> But even ignoring the usual P4 "I suck at things that aren't totally 
> normal", cmov is actually not a great idea. You can always replace it by
> 
> 		j<negated condition> forward
> 		mov ..., %reg
> 	forward:
...
...
> In contrast, if you use a predicated instruction, ALL of it is on the 
> critical path. Calculating the conditional is on the critical path. 
> Calculating the value that gets used is obviously ALSO on the critical 
> path, but so is the calculation for the value that DOESN'T get used too. 
> So the cmov - rather than speeding things up - actually slows things down, 
> because it makes more code be dependent on each other.

Why CPU people do not internally convert cmov into jmp,mov pair?
--
vda

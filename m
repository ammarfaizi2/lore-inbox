Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752011AbWFLO4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbWFLO4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbWFLO4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:56:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:9179 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752011AbWFLO4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:56:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EV788KCuQHu805lCNwQfSHLtLcjMeY3PL+hnUJLFtYa276547lbHmRHFamwU71oWGv9rGGLXgoo/RWsUvbjgBrHyQzQhnaZgKNgYD94VAx/1jW4fxMa6EWUTYZcHkiiNAj+WHWLMuT6DJlBTYit0TKRI1CK0LDyo8hiYndNBkA4=
Message-ID: <448D80BF.7010806@gmail.com>
Date: Mon, 12 Jun 2006 16:57:03 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
References: <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com> <20060610092412.66dd109f.akpm@osdl.org> <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com> <20060610100318.8900f849.akpm@osdl.org> <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com> <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com> <Pine.LNX.4.64.0606101118410.7535@schroedinger.engr.sgi.com> <20060612110537.GA11358@elte.hu> <6bffcb0e0606120650l7116ac17vc3a0379194b56315@mail.gmail.com> <20060612142028.GA22154@elte.hu>
In-Reply-To: <20060612142028.GA22154@elte.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar napisał(a):
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> 
>> I just tried your latest lockdep-combo-2.6.17-rc6-mm2 patch, and I get 
>> many warnings
>>
>> WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/sound/core/snd-pcm.ko
>> needs unknown symbol down_write
> 
> ok, i have uploaded a new version - does that work any better?
> 
> 	Ingo
> 

Yes, thanks.

I forgot about this

WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/fs/ntfs/ntfs.ko needs unknown symbol lockdep_on
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/fs/ntfs/ntfs.ko needs unknown symbol lockdep_off
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/fs/ntfs/ntfs.ko needs unknown symbol lockdep_on
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/fs/ntfs/ntfs.ko needs unknown symbol lockdep_off

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

----
diff -uprN -X linux-mm/Documentation/dontdiff linux-mm-clean/kernel/lockdep.c linux-mm/kernel/lockdep.c
--- linux-mm-clean/kernel/lockdep.c	2006-06-12 16:50:02.000000000 +0200
+++ linux-mm/kernel/lockdep.c	2006-06-12 16:46:42.000000000 +0200
@@ -130,11 +130,15 @@ void lockdep_off(void)
  	current->lockdep_recursion++;
  }

+EXPORT_SYMBOL(lockdep_off);
+
  void lockdep_on(void)
  {
  	current->lockdep_recursion--;
  }

+EXPORT_SYMBOL(lockdep_on);
+
  /*
   * Debugging switches:
   */


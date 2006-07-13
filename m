Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWGMRdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWGMRdz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWGMRdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:33:55 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:37391 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S1030262AbWGMRdy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:33:54 -0400
Message-ID: <44B683EB.20709@stud.feec.vutbr.cz>
Date: Thu, 13 Jul 2006 19:33:31 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE: Touch NMI watchdog during resume from STR
References: <44B61D0A.7010305@stud.feec.vutbr.cz> <p73ejwpmy6m.fsf@verdi.suse.de>
In-Reply-To: <p73ejwpmy6m.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-3.9 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0085]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Michal Schmidt <xschmi00@stud.feec.vutbr.cz> writes:
>> if (stat == 0xff)
>>  			return -ENODEV;
>>  		touch_softlockup_watchdog();
>> +		touch_nmi_watchdog();
> You can remove the touch_softlock_watchdog then. It's implied in 
> touch_nmi_watchdog

I don't think that's always true. There are architectures where 
touch_nmi_watchdog is a NOP. This is in include/linux/nmi.h:

#ifdef ARCH_HAS_NMI_WATCHDOG
extern void touch_nmi_watchdog(void);
#else
# define touch_nmi_watchdog() do { } while(0)
#endif

Michal

Return-Path: <linux-kernel-owner+w=401wt.eu-S1030353AbWL3WJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWL3WJ3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 17:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWL3WJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 17:09:28 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:48394 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030353AbWL3WJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 17:09:28 -0500
Date: Sat, 30 Dec 2006 23:08:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sergey Vlasov <vsu@altlinux.ru>
cc: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: ip_tables init broken [fixd]
In-Reply-To: <20061230213048.07238350.vsu@altlinux.ru>
Message-ID: <Pine.LNX.4.61.0612302308020.32449@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0612301738001.32449@yvahk01.tjqt.qr>
 <20061230213048.07238350.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 30 2006 21:30, Sergey Vlasov wrote:
>On Sat, 30 Dec 2006 18:14:35 +0100 (MET) Jan Engelhardt wrote:
>
>> when the ip_tables module is loaded automatically when inserting the
>> first rule, something gets screwed up, as -L -v -n shows:
>>
>>
>> 17:39 ichi:~ # lsmod | grep ip_tables
>> 17:39 ichi:~ # iptables -t mangle -A FORWARD -i eth1 -j MARK --set-mark 161
>> 17:39 ichi:~ # iptables -t mangle -A FORWARD -i eth1 -j MARK --set-mark 161
>> 17:39 ichi:~ # iptables -t mangle -L -v -n | grep eth1
>> p b targ pr opt in  out src       dst
>> 0 0 MARK 0  -- eth1 *   0.0.0.0/0 0.0.0.0/0  0xa1
>> 0 0 MARK 0  -- eth1 *   0.0.0.0/0 0.0.0.0/0  MARK set 0xa1
>>
>> Everything is fine if ip_tables was loaded before.
>>
>> This box runs 2.6.18.5. Can anyone confirm this bug?
>
>Looks like this problem was fixed between iptables releases 1.3.5 and
>1.3.7 (the old buggy version was trying to detect whether the kernel
>supports the newer MARK target version before loading the ip_tables
>module, therefore the check was giving bogus results).

Yup, upgrading to 1.3.7 fixed the problem, thanks for giving hint.
(netfilter svn commit #6692 seems relevant)

	-`J'
-- 

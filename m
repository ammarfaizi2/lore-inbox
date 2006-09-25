Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWIYMrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWIYMrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWIYMrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:47:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:15502 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750831AbWIYMrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:47:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=modyTyliFdAMGctguB9uMO0g5A/6BxsXoNVXT7vU8s7uK+VWBy08F24YKJ3E5XlXRQsTDrn+QIstODvJyf9Z6cFTSWVJY0drZait9WdTvQ2O/IQOpNLVPyrzyfcuRA2Tii+/zCG8zIEI8asFoUtxfHZJIrZ62PozlZVRbsxawgQ=
Message-ID: <b6fcc0a0609250547p551f49bcgab46192e7fa55a39@mail.gmail.com>
Date: Mon, 25 Sep 2006 16:47:08 +0400
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: hvc_iseries.c: overwriting spin_lock_irqsave()
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen, -git4 contains the following code

drivers/char/hvc_iseries.c:

static int put_chars(uint32_t vtermno, const char *buf, int count)
{
            unsigned long flags;

            spin_lock_irqsave(&consolelock, flags);
            if (viochar_is_console(pi) && !viopath_isactive(pi->lp)) {
                          spin_lock_irqsave(&consoleloglock, flags);

So, old flags are lost.

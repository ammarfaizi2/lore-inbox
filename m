Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVHMDTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVHMDTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 23:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVHMDTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 23:19:04 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:56247 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S1750894AbVHMDTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 23:19:03 -0400
Mime-Version: 1.0 (Apple Message framework v622)
Content-Transfer-Encoding: 7bit
Message-Id: <c10854018590b2287bc64888d842a4ac@iki.fi>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Teemu Koponen <tkoponen@iki.fi>
Subject: Opening of blocking FIFOs not reliable?
Date: Fri, 12 Aug 2005 20:18:59 -0700
X-Mailer: Apple Mail (2.622)
X-Spam-Niksula: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Opening a FIFO for WR_ONLY should release a previously blocked RD_ONLY 
open. I suspect this is not guaranteed on a heavily loaded Linux box.

Consider fs/fifo.c (of 2.6.13-rc6-git4) and its wait_for_partner() and 
wake_up_partner() functions. I think wait_for_partner()'s while loop 
never exits, *iff* the writer, after opening the FIFO, closes it before 
the reader gets scheduled. Shouldn't the writer's open() block until 
the reader's open() is done?

Teemu

--


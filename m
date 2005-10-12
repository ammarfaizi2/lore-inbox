Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVJLCNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVJLCNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 22:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVJLCNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 22:13:18 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:58516 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751193AbVJLCNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 22:13:18 -0400
Message-ID: <434C710C.2040305@nortel.com>
Date: Tue, 11 Oct 2005 20:12:28 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux@horizon.com
CC: dev@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: SMP syncronization on AMD processors (broken?)
References: <20051011235017.21719.qmail@science.horizon.com>
In-Reply-To: <20051011235017.21719.qmail@science.horizon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2005 02:12:38.0534 (UTC) FILETIME=[6B1B6A60:01C5CED2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:

> The right thing to do here is to wait for the flag to be set *outside*
> the lock, and then re-validate inside the lock:

This may work on some processors, but on others the read of "progress" 
in XXX, or the write in YYY may require arch-specific code to force the 
update out to other cpus.

Alternately, explicitly atomic operations should suffice, but a simple 
increment is probably not enough for portable code.

Chris

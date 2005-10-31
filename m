Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVJaPrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVJaPrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVJaPrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:47:09 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:16570 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932282AbVJaPrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:47:08 -0500
Message-ID: <43663C67.2080902@nortel.com>
Date: Mon, 31 Oct 2005 09:46:47 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: madhu.subbaiah@wipro.com, linux-kernel@vger.kernel.org
Subject: Re: select() for delay.
References: <EE111F112BBFF24FB11DB557FA2E5BF301992F02@BLR-EC-MBX02.wipro.com> <200510302006.15892.arnd@arndb.de>
In-Reply-To: <200510302006.15892.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2005 15:46:47.0682 (UTC) FILETIME=[4D511E20:01C5DE32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Maandag 24 Oktober 2005 12:55, madhu.subbaiah@wipro.com wrote:

>>This patch improves the sys_select() execution when used for delay. 

> Please describe what aspect of the syscall is improved. Is this only
> speeding up the execution for the delay case while slowing down
> the normal case, or do the actual semantics improve?

It appears to simply speed up the delay case.

One thing that I noticed though--the patch had the following line:

if ((n == 0) && (inp == NULL) && (outp == NULL) && (exp == NULL)) {


Would it be enought to just do the following?

if (n == 0) {

Given that if any of the fd_set pointers are non-empty, "n" ought to be 
non-zero, would this be a sufficient check?

Chris

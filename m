Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWEWCDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWEWCDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 22:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWEWCDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 22:03:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17812 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751246AbWEWCDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 22:03:47 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: NMI problems with Dell SMP Xeons 
In-reply-to: Your message of "Tue, 23 May 2006 03:55:48 +0200."
             <200605230355.48399.ak@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 May 2006 12:02:10 +1000
Message-ID: <5767.1148349730@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on Tue, 23 May 2006 03:55:48 +0200) wrote:
>nd add special cases just to get an NMI send with different vector.
>> 
>> I have never disagreed that all NMIs will end up on the NMI vector (2).
>
>The problem was that KDB had an own handler for its debug vector,
>although that was only ever called as NMI.

You are confusing KDB_ENTER (instruction code 'int 0x81') with
KDB_VECTOR (IPI).  KDB_ENTER needs its own int handler which is not an
NMI, KDB_VECTOR does not need (and does not have) its own handler, it
is handled by the NMI vector.


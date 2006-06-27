Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWF0M7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWF0M7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWF0M7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:59:45 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:60711 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932185AbWF0M7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:59:45 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>, stsp@aknet.ru,
       linux-kernel@vger.kernel.org
Subject: Re: the creation of boot_cpu_init() is wrong and accessing uninitialised data 
In-reply-to: Your message of "Mon, 26 Jun 2006 22:03:37 MST."
             <20060626220337.06014184.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Jun 2006 23:00:09 +1000
Message-ID: <31382.1151413209@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Mon, 26 Jun 2006 22:03:37 -0700) wrote:
>It's a bit odd - I think non-zero BSPs happen a bit more often than
>only-on-voyager.

AFAICR, the BSP is supposed to be logical cpu 0 on all architectures.
Most architectures assign logical cpu 0 to the BSP, even if the BSP has
a non-zero hard_smp_processor_id.  ia64 even has this

int __cpu_disable(void)
{
        int cpu = smp_processor_id();

	/*
	 * dont permit boot processor for now
	 */
	if (cpu == 0 && !bsp_remove_ok) {


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310782AbSCHJuR>; Fri, 8 Mar 2002 04:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310781AbSCHJuI>; Fri, 8 Mar 2002 04:50:08 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:46090 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S310779AbSCHJuF>; Fri, 8 Mar 2002 04:50:05 -0500
Date: Fri, 8 Mar 2002 09:49:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ed Vance <EdV@macrolink.com>
Cc: "'Bill Nottingham'" <notting@redhat.com>,
        "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial.c procfs kudzu - discussion
Message-ID: <20020308094918.A16358@flint.arm.linux.org.uk>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76E4@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76E4@EXCHANGE>; from EdV@macrolink.com on Thu, Mar 07, 2002 at 03:12:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 03:12:54PM -0800, Ed Vance wrote:
> This is not the result of a recent change to the serial driver. I don't 
> know how far back this bug goes, but I suspect it is as old as the proc 
> fs serial support. 

I think there are two bugs here that need treating in different ways.

1. Not displaying port statistics for iomem-based ports.  This is
   probably an oversight when iomem ports were added to the serial
   driver.

2. "port:" entry being 0.  I don't think we really want to report IO
   port or memory addresses here without giving userspace some
   indication which we're reporting.

For 2, I'd suggest replacing "port:" with "mem:" for iomem ports, and
changing the serinfo: line to reflect the changed format (this is
probably ignored by kudzu though.)

Does this sound reasonable?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


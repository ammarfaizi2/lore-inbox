Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTENJYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 05:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTENJYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 05:24:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57359 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261570AbTENJYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 05:24:34 -0400
Date: Wed, 14 May 2003 10:34:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Alex Riesen <alexander.riesen@synopsys.COM>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.5.69+bk: "irq 15: nobody cared!" on a Compaq Armada 1592DT
Message-ID: <20030514103458.D26687@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Alex Riesen <alexander.riesen@synopsys.COM>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <20030513134907.GF32559@Synopsys.COM> <Pine.LNX.4.50.0305131020070.5420-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50.0305131020070.5420-100000@montezuma.mastecende.com>; from zwane@linuxpower.ca on Tue, May 13, 2003 at 02:23:40PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 02:23:40PM -0400, Zwane Mwaikambo wrote:
> Bugger, this is due to yenta_probe_irq.

Umm, but this is yee standard old interrupt probing - calling
probe_irq_on() and causing interrupts to be generated.

This seems to be something that these IRQ changes completely missed;
interrupt probing does not register interrupt handlers, so "retval"
in handle_IRQ_event will always be zero, and we'll always produce
these complaints.  I'm sure there's lots of other older drivers using
IRQ probing which are going to suffer in a similar way.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


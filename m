Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbTGOHli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 03:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266823AbTGOHli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 03:41:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63237 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266807AbTGOHlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 03:41:35 -0400
Date: Tue, 15 Jul 2003 08:56:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Message-ID: <20030715085622.A32119@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Frank <mflt1@micrologica.com.hk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <200307141937.29584.mflt1@micrologica.com.hk> <20030714155051.A31395@flint.arm.linux.org.uk> <200307151331.40428.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307151331.40428.mflt1@micrologica.com.hk>; from mflt1@micrologica.com.hk on Tue, Jul 15, 2003 at 01:31:37PM +0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 01:31:37PM +0800, Michael Frank wrote:
> problems seen:
> 
> - yenta_probe pci_save_state saves irq as ff. Moved to end of function, result same  

irq was 0xff at boot, so it is neither here nor there whether it remains
0xff after a resume.  If it works at boot with 0xff, it should work after
a resume with 0xff.

> - both swsusp and ACPI/S3 do _not_ call yenta_suspend and yenta_init,
>   so it still wont work

Please confirm whether pcmcia_socket_dev_suspend() is called from
yenta.c with SUSPEND_SAVE_STATE and not zero.  (it should be
SUSPEND_SAVE_STATE.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


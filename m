Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTDOMqO (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbTDOMqO 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:46:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42763 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261346AbTDOMqN (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 08:46:13 -0400
Date: Tue, 15 Apr 2003 13:57:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Writing modules for 2.5
Message-ID: <20030415135758.C32468@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel> <p73adesxane.fsf@oldwotan.suse.de> <yw1xllyc7yoz.fsf@zaphod.guide> <1050406513.27745.32.camel@dhcp22.swansea.linux.org.uk> <yw1xbrz87x59.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <yw1xbrz87x59.fsf@zaphod.guide>; from mru@users.sourceforge.net on Tue, Apr 15, 2003 at 02:39:14PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 02:39:14PM +0200, Måns Rullgård wrote:
> My situation is like this: I am converting a char device driver to
> work with linux 2.5.  In the open and close functions there are
> MOD_INC/DEC_USECOUNT calls.  The question is what they should be
> replaced with.  Will it be handled correctly without them?

If it's a character device driver using the struct file_operations,
set the owner field as Alan mentioned, and remove the
MOD_{INC,DEC}_USE_COUNT macros from the open/close methods.  This
allows chrdev_open() (in fs/char_dev.c) to increment your module use
count automatically.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


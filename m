Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUCSShx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUCSShx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:37:53 -0500
Received: from hermes.e-matters.de ([217.69.76.213]:6857 "HELO e-matters.de")
	by vger.kernel.org with SMTP id S263107AbUCSShs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:37:48 -0500
Date: Fri, 19 Mar 2004 19:35:15 +0100
From: Stefan Esser <s.esser@e-matters.de>
To: linux-kernel@vger.kernel.org
Subject: [OVERFLOW] in arch/mips/au1000/common/power.c
Message-ID: <20040319183515.GA29837@php.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for the possible double posting, but my other mail seems
to be lost...

The following code seems very fishy ;)

static int pm_do_freq(ctl_table * ctl, int write, struct file *file,
                      void *buffer, size_t * len)
{
        int retval = 0, i;
        unsigned long val, pll;
#define TMPBUFLEN 64
#define MAX_CPU_FREQ 396
        char buf[8], *p;

	...

        spin_lock_irqsave(&pm_lock, flags);
        if (!write) {
                *len = 0;
        } else {
                /* Parse the new frequency */
                if (*len > TMPBUFLEN - 1) {
                        spin_unlock_irqrestore(&pm_lock, flags);
                        return -EFAULT;
                }
                if (copy_from_user(buf, buffer, *len)) {
                        spin_unlock_irqrestore(&pm_lock, flags);
                        return -EFAULT;
                }
                buf[*len] = 0;
                p = buf;

Earth to linux kernel. Earth to linux kernel. Your buffer is only 8
bytes big and not TMPBUFLEN - 1

Looks like a 56 byte stackoverflow to me ;)

Stefan Esser

-- 

--------------------------------------------------------------------------
 Stefan Esser                                        s.esser@e-matters.de
 e-matters Security                         http://security.e-matters.de/

 GPG-Key                gpg --keyserver pgp.mit.edu --recv-key 0xCF6CAE69 
 Key fingerprint       B418 B290 ACC0 C8E5 8292  8B72 D6B0 7704 CF6C AE69
--------------------------------------------------------------------------
 Did I help you? Consider a gift:            http://wishlist.suspekt.org/
--------------------------------------------------------------------------


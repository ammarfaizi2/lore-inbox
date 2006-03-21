Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWCUUvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWCUUvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWCUUvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:51:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47761 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965105AbWCUUvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:51:18 -0500
Date: Tue, 21 Mar 2006 21:50:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announcing crypto suspend
Message-ID: <20060321205055.GA4327@elf.ucw.cz>
References: <20060320080439.GA4653@elf.ucw.cz> <1142879707.9475.4.camel@localhost.localdomain> <200603201954.45572.rjw@sisk.pl> <20060321094449.0760E12768C@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060321094449.0760E12768C@dungeon.inka.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 21-03-06 10:45:40, Andreas Jellinghaus wrote:
> Rafael J. Wysocki wrote:
> > First, you need to generate the RSA key pair using suspend-keygen and save
> > the output file as /etc/suspend.key (or something else pointed to by
> > the "RSA key file =" configuration parameter of suspend).  This file
> > contains the public modulus (n), public exponent (e) and
> > Blowfish-encrypted private exponent (d) of the RSA key pair.
> > 
> > Then, the suspend utility will load the contents of this file,  generate a
> > random session key (k) and initialization vector (i) for the image
> > encryption and use (n, e) to encrypt these values with RSA.  The encrypted
> > k, i as well as the contents of the RSA key file will be saved in the
> > image header.
> > 
> > The resume utility will read n, e and (encrypted) d as well as (encrypted)
> > k, i from the image header.  Then it will ask the user for a passphrase
> > and will try to decrypt d using it.  Next, it will use (n, e, d) to
> > decrypt k, i needed for decrypting the image.
> 
> what interface will those tools use? can I replace them with my own
> code, e.g. that uses smart cards instead of an encrypted public key
> on a disk?

It is userspace, so yes, you can use smart cards if you hack code at
suspend.sf.net a bit.
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...

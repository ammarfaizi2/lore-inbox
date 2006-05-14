Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWENA4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWENA4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 20:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWENA4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 20:56:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:28705 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751363AbWENA4I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 20:56:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KCYqYfDdXyhAD6ipiWgUzwPiV6fKHlqBIZgAq1X/zpzTr60AOUtzsYBy4sNiVLvZptX8UOtxU/hc2ATsKKWaF7umcxzUqgpOahGxJAnZyOCrft1cBPsXdl+vosUD4LHxupipaETxwCcAl5S/LOasAJxqDi6wyP7jmQFNt8yRxUY=
Message-ID: <9e4733910605131756q50ad5686n4ca8d5a8d1f9e3e1@mail.gmail.com>
Date: Sat, 13 May 2006 20:56:06 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Peter Jones" <pjones@redhat.com>, "Martin Mares" <mj@ucw.cz>,
       "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Dave Airlie" <airlied@linux.ie>,
       "Andrew Morton" <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@linux.intel.com>
In-Reply-To: <1147566572.21291.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041309.53910.bjorn.helgaas@hp.com>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <1146778197.27727.26.camel@localhost.localdomain>
	 <1147566572.21291.30.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> There are reasons why you may have to read the image at c0000... There's
> a bunch of laptops where it's in fact the only way to get to the video
> BIOS as it doesn't have a ROM attached to the video chip (it's burried
> in the main BIOS which thankfully copied it to c0000 when running it).
> In some cases, the BISO ROM self-modifies it's c0000 and it's that
> modified copy that the X (or fbdev) driver should get. Remeber that
> drivers needs access to the ROM for more than just POSTing the chip...

Whenever klibc gets merged it would probably be good to add a
libemu86. Did you get one put together that you're happy with?

Between the ROM attribute, klibc and libemu86 there will then be
enough support to write a tiny POST program that POSTs secondary and
non-x86 primary cards at boot. It will still need a little support in
sysfs for PCI bus VGA routing but we're almost there.

-- 
Jon Smirl
jonsmirl@gmail.com

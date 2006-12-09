Return-Path: <linux-kernel-owner+w=401wt.eu-S936919AbWLIPuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936919AbWLIPuy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 10:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937026AbWLIPux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 10:50:53 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:46033 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936919AbWLIPux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 10:50:53 -0500
Subject: Re: [PATCH] PCI legacy resource fix
From: Ben Collins <ben.collins@ubuntu.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061209131448.4c878b64@localhost.localdomain>
References: <20061206134143.GA6772@linux-mips.org>
	 <1165625178.7443.334.camel@gullible>
	 <20061209012552.GA15216@linux-mips.org>
	 <1165630410.7443.346.camel@gullible>
	 <20061209024627.6bb11a58@localhost.localdomain>
	 <1165651931.7443.377.camel@gullible>
	 <20061209131448.4c878b64@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Dec 2006 10:50:40 -0500
Message-Id: <1165679440.7443.416.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 13:14 +0000, Alan wrote:
> On Sat, 09 Dec 2006 03:12:11 -0500
> Ben Collins <ben.collins@ubuntu.com> wrote:
> > My controller is in legacy mode, however, it never gets to here because
> > of this call, just before this block of code:
> > 
> >         rc = pci_request_regions(pdev, DRV_NAME);
> >         if (rc) {
> >                 disable_dev_on_err = 0;
> >                 goto err_out;
> >         }
> 
> Then you don't have the fix applied that was posted. That code is not
> present in the form you pasted in the fixed version of the libata code.
> It is within an if (!legacy_mode)

I didn't see that patch until you mentioned it. Even still, there seems
to be one thing missing. I suspect you still want to take the bmdma
resource since both native and legacy use it. With the patch you
mentioned, that resource wont be requested in legacy mode.

Also, I did my patch as detailed as it is because of this line:

	/* TODO: What if one channel is in native mode ... */

If that's never going to be the case then the comment should go. If it
is possible, then my patch makes this work. The way things are now, it
will ignore a native mode port if it is sitting on the same controller
as a legacy mode one.

Want to re-evaluate the patch based on this info?

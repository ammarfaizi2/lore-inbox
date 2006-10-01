Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWJARdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWJARdt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWJARdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:33:49 -0400
Received: from zakalwe.fi ([80.83.5.154]:62147 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S932108AbWJARds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:33:48 -0400
Date: Sun, 1 Oct 2006 20:32:52 +0300
From: Heikki Orsila <shd@zakalwe.fi>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Eugeny S. Mints" <eugeny.mints@gmail.com>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Message-ID: <20061001173252.GB24539@zakalwe.fi>
References: <20060930022435.b2344b5f.eugeny.mints@gmail.com> <20061001152228.GA24539@zakalwe.fi> <20061001171032.GE2254@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061001171032.GE2254@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 07:10:32PM +0200, Pavel Machek wrote:
> On Sun 2006-10-01 18:22:28, Heikki Orsila wrote:
> > Some nitpicking about the patch follows..
> > 
> > On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
> > > +static long 
> > > +get_vtg(const char *vdomain)
> > > +{
> > > +	long ret = 0;
> > 
> > Unnecessary initialisation.
> 
> No, sorry.

In get_vtg(), if VOLTAGE_FRAMEWORK is defined then

	ret = vtg_get_voltage(v);

is the first user. If VOLTAGE_FRAMEWORK is not defined, the first user is:

	ret = vtg_get_voltage(&vhandle);

Then "return ret;" follows. I cannot see a path where 
pre-initialisation of ret does anything useful. If someone removed the
#else part, the compiler would bark.

> 
> > > +static long 
> > > +set_vtg(const char *vdomain, int val)
> > > +{
> > > +	long ret = 0;
> > 
> > here too.
> 
> Wrong again. automatic variables are not zero initialized.

My bad, this was a mistake. If VOLTAGE_FRAMEWORK is not defined, ret 
must be initialised. (the compiler would have noticed this one :-)

>> 'int i = 0;' happens in many functions.

for example, omap_pm_create_point() does this.

- Heikki

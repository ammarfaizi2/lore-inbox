Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUBCG1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 01:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265876AbUBCG1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 01:27:12 -0500
Received: from fmr05.intel.com ([134.134.136.6]:6367 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S265872AbUBCG1K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 01:27:10 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: FYI: ACPI 'sleep 1' resets atkbd keycodes
Date: Tue, 3 Feb 2004 14:27:01 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB669@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FYI: ACPI 'sleep 1' resets atkbd keycodes
Thread-Index: AcPqEL02YdsnNanxT12hCKCqSpK66gACPZHw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       "Vojtech Pavlik" <vojtech@suse.cz>, "P. Christeas" <p_christ@hol.gr>
Cc: <acpi-devel@lists.sourceforge.net>, "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Feb 2004 06:27:01.0689 (UTC) FILETIME=[BBC84A90:01C3EA1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This may be just a minor issue:
> > > I had to use the setkeycodes utility to enable some extra 
> keys (that
> > > weren't mapped by kernel's atkbd tables).
> > > After waking from sleep 1, those keys were reset. That 
> is, I had to
> > > use 'setkeycodes' again to customize the tables again.
> > >
> > > IMHO the way kernel works now is correct. It should *not* 
> have extra
> > > code just to handle that. Just make sure anybody that 
> alters his kbd
> > > tables puts some extra script to recover the tables after an ACPI
> > > wake.
> > > This should be more like a note to Linux distributors.
> > >
> > > Have a nice day.

Do you need a event through /proc/acpi/event that can notify userland of
resuming happend,
And let userland app have chance to invoke setkeycode, and other similar
things.

> -	/*
> -	 * Here we probably should check if the keyboard has 
> the same set that
> -         * it had before and bail out if it's different. But 
> this will most likely
> -         * cause new keyboard device be created... and for 
> the user it will look
> -         * like keyboard is lost
> -	 */
> +	if (atkbd->set != old_set) {
> +		/*
> +		 * ok, we woke up with a different keyboard 
> attached. Alhtough we could just
> +		 * signal failure it's not very nice as it will 
> most likely cause new keyboard
> +		 * device be created... and for the user it 
> will look like keyboard is lost.
> +		 */
> +		atkbd_set_name(atkbd);

Is it correct to think if the keyboard has the different set that it
had before , then keyboard has been replaced, without considering
it could be changed by setkeycode.

--Luming

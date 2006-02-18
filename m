Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWBRKDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWBRKDy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 05:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWBRKDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 05:03:54 -0500
Received: from master.altlinux.org ([62.118.250.235]:19731 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751125AbWBRKDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 05:03:53 -0500
Date: Sat, 18 Feb 2006 13:03:44 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit Bruchh?user <gbruchhaeuser@gmx.de>, Nicolas.Mailhot@LaPoste.net,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Patrizio Bassi <patrizio.bassi@gmail.com>,
       Bj?rn Nilsson <bni.swe@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
       jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
Message-ID: <20060218100344.GA8532@procyon.home>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Jens Axboe <axboe@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	"Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	"Yu, Luming" <luming.yu@intel.com>,
	Ben Castricum <lk@bencastricum.nl>, sanjoy@mrao.cam.ac.uk,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"Carlo E. Prelz" <fluido@fluido.as>,
	Gerrit Bruchh?user <gbruchhaeuser@gmx.de>,
	Nicolas.Mailhot@LaPoste.net, Jaroslav Kysela <perex@suse.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Patrizio Bassi <patrizio.bassi@gmail.com>,
	Bj?rn Nilsson <bni.swe@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>,
	"P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
	jinhong hu <jinhong.hu@gmail.com>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	linux-scsi@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>
References: <1139934883.14115.4.camel@mulgrave.il.steeleye.com> <1140054960.3037.5.camel@mulgrave.il.steeleye.com> <20060216171200.GD29443@flint.arm.linux.org.uk> <1140112653.3178.9.camel@mulgrave.il.steeleye.com> <20060216180939.GF29443@flint.arm.linux.org.uk> <1140113671.3178.16.camel@mulgrave.il.steeleye.com> <20060216181803.GG29443@flint.arm.linux.org.uk> <1140116969.3178.24.camel@mulgrave.il.steeleye.com> <20060216200138.GA4203@suse.de> <1140223363.3231.9.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <1140223363.3231.9.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 17, 2006 at 04:42:43PM -0800, James Bottomley wrote:
> +static void execute_in_process_context_work(void *data)
> +{
> +	void (*fn)(void *data);
> +	struct execute_work *ew = data;
> +
> +	fn = ew->fn;
> +	data = ew->data;
> +
> +	fn(data);
> +}

After removing kfree(), which was here in the initial implementation,
this function became a thunk which does nothing useful - we can just
stick fn and data directly into work_struct.

> +
> +/**
> + * execute_in_process_context - reliably execute the routine with user context
> + * @fn:		the function to execute
> + * @data:	data to pass to the function
> + *
> + * Executes the function immediately if process context is available,
> + * otherwise schedules the function for delayed execution.
> + *
> + * Returns:	0 - function was executed
> + *		1 - function was scheduled for execution
> + */
> +int execute_in_process_context(void (*fn)(void *data), void *data,
> +			       struct execute_work *ew)
> +{
> +	if (!in_interrupt()) {
> +		fn(data);
> +		return 0;
> +	}
> +
> +	INIT_WORK(&ew->work, execute_in_process_context_work, ew);
> +	ew->fn = fn;
> +	ew->data = data;
> +	schedule_work(&ew->work);
> +
> +	return 1;
> +}

Then this becomes:

int execute_in_process_context(void (*fn)(void *data), void *data,
			       struct work_struct *work)
{
	if (!in_interrupt()) {
		fn(data);
		return 0;
	}

	INIT_WORK(work, fn, data);
	schedule_work(work);
	return 1;
}

(and struct execute_work is no longer needed).

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9vEAW82GfkQfsqIRAhsQAKCLA744b1fcsveBRiqrCGBfZz5e5ACgglBh
aztogAZPXOqeAynnILwmbZU=
=eoPh
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

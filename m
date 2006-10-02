Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWJBHhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWJBHhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 03:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWJBHhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 03:37:14 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:42931 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1750715AbWJBHhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 03:37:12 -0400
Message-ID: <4520DE2C.7000300@web.de>
Date: Mon, 02 Oct 2006 09:38:52 +0000
From: Michael Rasenberger <miraze@web.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060926)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1 violates sandbox feature on linux distribution
References: <451ABE0E.2030904@web.de> <20061001104046.GA10205@uranus.ravnborg.org>
In-Reply-To: <20061001104046.GA10205@uranus.ravnborg.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello,

maybe this helps: http://bugday.gentoo.org/sandbox.html.
Basically the sandbox is a kind of security mechanism that prevents
files from being created outside a specific directory during package
installation phases (unpacking, compiling ..).

If the package uses KBuild to make a kernel module the sandbox is
triggered under 2.6.18-mm1 because of the temporary file creation in the
kernel directory.

Of course this feature can be bypassed (e.g. disable sandbox), but if
there is a way to do these tests without file creation it would be much
more consistent. Btw. is there a reason for creating the file? AFAICS
there is not test performed on it?

I have to admit that due to the nature of -mm of being a testbed this is
not a critical issue.

Michael


Sam Ravnborg wrote:
> On Wed, Sep 27, 2006 at 06:08:14PM +0000, Michael Rasenberger wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hello,
>>
>> when building external kernel module on gentoo linux distribution,
>> 2.6.18-mm1 violates gentoo's sandbox feature due to file creation in
>> "as-instr" test in scripts/Kbuild.include. (AFAIK due to removal of
>> revert-x86_64-mm-detect-cfi.patch)
> 
> Can you point to to some description of this sandbox feature.
> The error you point out looks pretty generic and should happen
> in several places - so I need to understand what problem I shall
> fix before trying to fix it.
> 
> The point is that we have other places where we create temporary files
> so this should not be the only issue.
> 
> 	Sam
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFIN4sC0GEtIi2MlcRAvrwAJ9fXuyfdd6DlpHlzZf0ndKC3WCFmQCfQ3to
E5BMlencOsGm/KMYADYp91A=
=n6sF
-----END PGP SIGNATURE-----

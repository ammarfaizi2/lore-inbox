Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVAEGYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVAEGYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 01:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVAEGYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 01:24:52 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:44268 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262263AbVAEGYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 01:24:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=B+GZN98r7rzbU0tVUo0VtCnjGPd1gLf7mGVMLGUODFeFF8/m/Hakx046FyPrmEsM0MmMLqob14q05vyngP4+waz9v7u2hNkI6LUuWQ35zCUuZd6zi2CuhMn/JSKilqevc83ojAtIc/sdSaJXzBmCVlg8n9lpoKcbROc23RQXZH4=
Message-ID: <2cd57c9005010422241a1e36da@mail.gmail.com>
Date: Wed, 5 Jan 2005 14:24:48 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Paul Bain <prbain@essex.ac.uk>
Subject: Re: PROBLEM: 2.6.10 oops on startup
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1104899778.1992.45.camel@sofa.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16_14752021.1104906288574"
References: <1104605177.6137.92.camel@sofa.co.uk> <41DAE494.1020807@osdl.org>
	 <1104899778.1992.45.camel@sofa.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_16_14752021.1104906288574
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 05 Jan 2005 04:36:18 +0000, Paul Bain <prbain@essex.ac.uk> wrote:
> On Tue, 2005-01-04 at 18:46, Randy.Dunlap wrote:
> > Have you tested any 2.6.10-bk# versions to see if this has been
> > fixed by recent patches?
> > If not, please try that and let us know, then I'll look at it
> > more if needed.
> >
> > Thanks,
> > ~Randy
> 
> Hi, thanks for the response. I tried it with 2.6.10-bk7 and it crashed
> with
> 

This is a quick fix. Please try the attached patch.


 coywolf




-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/

------=_Part_16_14752021.1104906288574
Content-Type: text/x-patch; name="fix-acpi_ex_load_op.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="fix-acpi_ex_load_op.patch"

diff -Nrup linux-2.6.10/drivers/acpi/executer/exconfig.c linux-2.6.10-cy/dr=
ivers/acpi/executer/exconfig.c
--- linux-2.6.10/drivers/acpi/executer/exconfig.c=092004-10-19 05:54:32.000=
000000 +0800
+++ linux-2.6.10-cy/drivers/acpi/executer/exconfig.c=092005-01-05 14:19:18.=
000000000 +0800
@@ -368,7 +368,7 @@ acpi_ex_load_op (
 =09=09 */
 =09=09status =3D acpi_ex_read_data_from_field (walk_state, obj_desc, &buff=
er_desc);
 =09=09if (ACPI_FAILURE (status)) {
-=09=09=09goto cleanup;
+=09=09=09return_ACPI_STATUS (status);
 =09=09}
=20
 =09=09table_ptr =3D ACPI_CAST_PTR (struct acpi_table_header, buffer_desc->=
buffer.pointer);

------=_Part_16_14752021.1104906288574--

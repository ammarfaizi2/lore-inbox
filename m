Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTL2Sxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTL2Sxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:53:44 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:5578
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S264127AbTL2Sx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:53:29 -0500
Date: Mon, 29 Dec 2003 10:53:24 -0800
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.6.0-mm2
Message-ID: <20031229185324.GA9954@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Dax Kelson <dax@gurulabs.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <20031229013223.75c531ed.akpm@osdl.org> <1072722682.15739.2.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <1072722682.15739.2.camel@mentor.gurulabs.com>
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2003 at 11:31:22AM -0700, Dax Kelson wrote:
> WARNING: /lib/modules/2.6.0-mm2/kernel/drivers/net/wireless/wavelan_cs.ko=
 needs unknown symbol CardServices

Here's a fix for that.

--- linux-2.6.0/drivers/net/wireless/wavelan_cs.c~	2003-12-29 10:51:40.0000=
00000 -0800
+++ linux-2.6.0/drivers/net/wireless/wavelan_cs.c	2003-12-29 10:50:54.00000=
0000 -0800
@@ -3802,7 +3802,7 @@
   printk(KERN_DEBUG "%s: ->wv_pcmcia_reset()\n", dev->name);
 #endif
=20
-  i =3D CardServices(AccessConfigurationRegister, link->handle, &reg);
+  i =3D pcmcia_access_configuration_register(link->handle, &reg);
   if(i !=3D CS_SUCCESS)
     {
       cs_error(link->handle, AccessConfigurationRegister, i);
@@ -3816,7 +3816,7 @@
=20
   reg.Action =3D CS_WRITE;
   reg.Value =3D reg.Value | COR_SW_RESET;
-  i =3D CardServices(AccessConfigurationRegister, link->handle, &reg);
+  i =3D pcmcia_access_configuration_register(link->handle, &reg);
   if(i !=3D CS_SUCCESS)
     {
       cs_error(link->handle, AccessConfigurationRegister, i);
@@ -3825,7 +3825,7 @@
      =20
   reg.Action =3D CS_WRITE;
   reg.Value =3D COR_LEVEL_IRQ | COR_CONFIG;
-  i =3D CardServices(AccessConfigurationRegister, link->handle, &reg);
+  i =3D pcmcia_access_configuration_register(link->handle, &reg);
   if(i !=3D CS_SUCCESS)
     {
       cs_error(link->handle, AccessConfigurationRegister, i);
@@ -4018,16 +4018,16 @@
     {
       tuple.Attributes =3D 0;
       tuple.DesiredTuple =3D CISTPL_CONFIG;
-      i =3D CardServices(GetFirstTuple, handle, &tuple);
+      i =3D pcmcia_get_first_tuple(handle, &tuple);
       if(i !=3D CS_SUCCESS)
 	break;
       tuple.TupleData =3D (cisdata_t *)buf;
       tuple.TupleDataMax =3D 64;
       tuple.TupleOffset =3D 0;
-      i =3D CardServices(GetTupleData, handle, &tuple);
+      i =3D pcmcia_get_tuple_data(handle, &tuple);
       if(i !=3D CS_SUCCESS)
 	break;
-      i =3D CardServices(ParseTuple, handle, &tuple, &parse);
+      i =3D pcmcia_parse_tuple(handle, &tuple, &parse);
       if(i !=3D CS_SUCCESS)
 	break;
       link->conf.ConfigBase =3D parse.config.base;
@@ -4045,7 +4045,7 @@
   link->state |=3D DEV_CONFIG;
   do
     {
-      i =3D CardServices(RequestIO, link->handle, &link->io);
+      i =3D pcmcia_request_io(link->handle, &link->io);
       if(i !=3D CS_SUCCESS)
 	{
 	  cs_error(link->handle, RequestIO, i);
@@ -4056,7 +4056,7 @@
        * Now allocate an interrupt line.  Note that this does not
        * actually assign a handler to the interrupt.
        */
-      i =3D CardServices(RequestIRQ, link->handle, &link->irq);
+      i =3D pcmcia_request_irq(link->handle, &link->irq);
       if(i !=3D CS_SUCCESS)
 	{
 	  cs_error(link->handle, RequestIRQ, i);
@@ -4068,7 +4068,7 @@
        * the I/O windows and the interrupt mapping.
        */
       link->conf.ConfigIndex =3D 1;
-      i =3D CardServices(RequestConfiguration, link->handle, &link->conf);
+      i =3D pcmcia_request_configuration(link->handle, &link->conf);
       if(i !=3D CS_SUCCESS)
 	{
 	  cs_error(link->handle, RequestConfiguration, i);
@@ -4084,8 +4084,7 @@
       req.Attributes =3D WIN_DATA_WIDTH_8|WIN_MEMORY_TYPE_AM|WIN_ENABLE;
       req.Base =3D req.Size =3D 0;
       req.AccessSpeed =3D mem_speed;
-      link->win =3D (window_handle_t)link->handle;
-      i =3D CardServices(RequestWindow, &link->win, &req);
+      i =3D pcmcia_request_window(&link->handle, &req, &link->win);
       if(i !=3D CS_SUCCESS)
 	{
 	  cs_error(link->handle, RequestWindow, i);
@@ -4096,7 +4095,7 @@
       dev->mem_end =3D dev->mem_start + req.Size;
=20
       mem.CardOffset =3D 0; mem.Page =3D 0;
-      i =3D CardServices(MapMemPage, link->win, &mem);
+      i =3D pcmcia_map_mem_page(link->win, &mem);
       if(i !=3D CS_SUCCESS)
 	{
 	  cs_error(link->handle, MapMemPage, i);
@@ -4170,10 +4169,10 @@
=20
   /* Don't bother checking to see if these succeed or not */
   iounmap((u_char *)dev->mem_start);
-  CardServices(ReleaseWindow, link->win);
-  CardServices(ReleaseConfiguration, link->handle);
-  CardServices(ReleaseIO, link->handle, &link->io);
-  CardServices(ReleaseIRQ, link->handle, &link->irq);
+  pcmcia_release_window(link->win);
+  pcmcia_release_configuration(link->handle);
+  pcmcia_release_io(link->handle, &link->io);
+  pcmcia_release_irq(link->handle, &link->irq);
=20
   link->state &=3D ~DEV_CONFIG;
=20
@@ -4761,10 +4760,10 @@
   client_reg.event_callback_args.client_data =3D link;
=20
 #ifdef DEBUG_CONFIG_INFO
-  printk(KERN_DEBUG "wavelan_attach(): almost done, calling CardServices\n=
");
+  printk(KERN_DEBUG "wavelan_attach(): almost done, calling pcmcia_registe=
r_client\n");
 #endif
=20
-  ret =3D CardServices(RegisterClient, &link->handle, &client_reg);
+  ret =3D pcmcia_register_client(&link->handle, &client_reg);
   if(ret !=3D 0)
     {
       cs_error(link->handle, RegisterClient, ret);
@@ -4815,7 +4814,7 @@
=20
   /* Break the link with Card Services */
   if(link->handle)
-    CardServices(DeregisterClient, link->handle);
+    pcmcia_deregister_client(link->handle);
    =20
   /* Remove the interface data from the linked list */
   if(dev_list =3D=3D link)
@@ -4938,7 +4937,7 @@
 	  {
       	    if(link->open)
 	      netif_device_detach(dev);
-      	    CardServices(ReleaseConfiguration, link->handle);
+      	    pcmcia_release_configuration(link->handle);
 	  }
 	break;
=20
@@ -4948,7 +4947,7 @@
       case CS_EVENT_CARD_RESET:
 	if(link->state & DEV_CONFIG)
 	  {
-      	    CardServices(RequestConfiguration, link->handle, &link->conf);
+      	    pcmcia_request_configuration(link->handle, &link->conf);
       	    if(link->open)	/* If RESET -> True, If RESUME -> False ? */
 	      {
 		wv_hw_reset(dev);

--=20
Joshua Kwan

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP/B4IqOILr94RG8mAQIPdw/+PThLgpD0AN/w/i3XmNkBZUmU2RZg9EoU
rgHhLec/flmVNTQalQQvyJl0EQUg0EDxBI7JfefJSQX3crmIEQJycIEMgPRg1CZj
Rh0WR+q+sCEczxppl1iKt6NMJrUbWZI+3i+CP4GNJPWKN8vwoka9BW2OVDVdqShO
9qXZ30Gk8LiaK06Vaq2ADcg6Fjm8Nmif1h1OgHFyct2y7IyS9cSma93wbauSgiMZ
QwhjBSg6zWwy7ChToOeFQ/UfqQGehd/UgwNOKQEKZ1ReQW5tyZ1zdDk7tSsrKEr8
2idTHUEAilHnV3lw6B16Lv8ZWgJUircPRKcWUSplCcHT4o2sB+PKC8/5VsUfN/DJ
UHFgtC/CuUDsIy0DpvjvMZ7XgERj8yRq18rBsEKX667elf3/DBUA+Qb4IGXRKiJM
yV439DonzuFKWIXxTOOHM6ORL39hFDdg4Q4wvgLQZBMElIMtKnqoTK6JZ1bsviKz
9vzz4ai1SUN0x47AsT9JXolKzoafA8vb+2A66W9R4/lNufamnz5Y09SEHyG+CPRD
qvXbo3IhBquODqSCO/Df3R2Uusg+wQAYrFO8D7FBFdFa6i+U7k3c3Imx5Fb79yjF
VfZOFWDMATq1y3w0rYFVwUX7E7Z+13g/EUXKltLhmQHdnDkoMzebCCy+WXJE+F+F
anqpmQj+S84=
=KtJG
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318298AbSGRSbc>; Thu, 18 Jul 2002 14:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318299AbSGRSbc>; Thu, 18 Jul 2002 14:31:32 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:20998 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318298AbSGRSba>;
	Thu, 18 Jul 2002 14:31:30 -0400
Date: Thu, 18 Jul 2002 11:33:09 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: driverfs updates
Message-ID: <20020718183309.GH15529@kroah.com>
References: <Pine.LNX.4.44.0207181050330.2542-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207181050330.2542-100000@cherise.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 20 Jun 2002 16:36:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:11:53AM -0700, Patrick Mochel wrote:
> - Fix all users of those functions

{sniff} everyone always forgets about the usb code {sniff}

This changeset should be applied to your tree.

greg k-h

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.740, 2002-07-18 11:30:44-07:00, greg@kroah.com
  USB: change driverfs callbacks to take void * and cast to struct device *


 usb.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)


diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Thu Jul 18 11:32:19 2002
+++ b/drivers/usb/core/usb.c	Thu Jul 18 11:32:19 2002
@@ -754,9 +754,10 @@
  * or more interfaces that are used concurrently 
  */
 static ssize_t
-show_config (struct device *dev, char *buf, size_t count, loff_t off)
+show_config (void *obj, char *buf, size_t count, loff_t off)
 {
-	struct usb_device	*udev;
+	struct device *dev = obj;
+	struct usb_device *udev;
 
 	if (off)
 		return 0;
@@ -773,9 +774,10 @@
  * can have different endpoints and class info.
  */
 static ssize_t
-show_altsetting (struct device *dev, char *buf, size_t count, loff_t off)
+show_altsetting (void *obj, char *buf, size_t count, loff_t off)
 {
-	struct usb_interface	*interface;
+	struct device *dev = obj;
+	struct usb_interface *interface;
 
 	if (off)
 		return 0;
@@ -789,8 +791,9 @@
 };
 
 /* product driverfs file */
-static ssize_t show_product (struct device *dev, char *buf, size_t count, loff_t off)
+static ssize_t show_product (void *obj, char *buf, size_t count, loff_t off)
 {
+	struct device *dev = obj;
 	struct usb_device *udev;
 	int len;
 
@@ -811,8 +814,9 @@
 
 /* manufacturer driverfs file */
 static ssize_t
-show_manufacturer (struct device *dev, char *buf, size_t count, loff_t off)
+show_manufacturer (void *obj, char *buf, size_t count, loff_t off)
 {
+	struct device *dev = obj;
 	struct usb_device *udev;
 	int len;
 
@@ -833,8 +837,9 @@
 
 /* serial number driverfs file */
 static ssize_t
-show_serial (struct device *dev, char *buf, size_t count, loff_t off)
+show_serial (void *obj, char *buf, size_t count, loff_t off)
 {
+	struct device *dev = obj;
 	struct usb_device *udev;
 	int len;
 

===================================================================


This BitKeeper patch contains the following changesets:
1.740
## Wrapped with gzip_uu ##


begin 664 bkpatch7191
M'XL(`+,)-ST``[55T6[3,!1]KK_B2GN!L29VXL1)IJ*Q#0$:$M.F/4^.XS:A
M:3S93@LH'X^30!F#;:P:39N;V-?GG.M[*N_!E9$ZFRRT7*`]>*^,S29+K7CI
M";5R(Q=*N1&_5"OI]TE^737M%__XS-\HO9P&7H1<UCFWHH2UU":;$"_<CMBO
M-S*;7+Q]=_7QS05"LQF<E+Q9R$MI839#5NDUKPMSQ&U9J\:SFC=F)2WOR;MM
M:A=@'+@K(BS$4=R1&%/6"5(0PBF1!0YH$E.T4J*4]9$R1>TIO;B[GI'$K8^B
MI`O2A,3H%(C'*`8<^)CY)`%"LA!GE$XQRS"&OMJC[5;`*P)3C([A>36?(`%7
ME\<9B&$A%+IRNS@W('A=YUPLC2,$RY<2UJHJ8!]X4[A)8_MQ8W4K+!1R70D)
M^^@,^M(P.O^US6CZQ`]"F&/T^I$Z1YW&;TW>_SQQJUZ*">MHY*1T.95A'B0D
MC60<A+RXLZF_P0BEY6VLOE])B"GNPCB,R.">O^<_;J4=Y:*GR,4QCH,4I\Y>
M,<:#O6+VA[OP?>X*8,K^B[V>R5EC$S[!5&^&KW/*^3W]V,%SIRQB0-"',9A2
M;:Z%:N;5`EZ,ZE3^^:`O1<-^WLX/P%3?Y+4%H=K&'D"MYG/WYNXO>ZATA$HA
M0),[E;@(,W!HA]LII_GZYW3K'@X=!(L'B"$,:GAMC;2V:G92Q)(1+OEW155C
M7;MXG[%][)6EP0`U!&.YK028']2#T!NMBA[CR2H=9N@P'Y!WFA#:DX]A8%OQ
MIG7*;*NEWH$R(=%CE.'0B3$,E.Z\JGB]"UG('B;;'EON'''_CW8UHWG`\#PM
*T'<BE>28*`<`````
`
end

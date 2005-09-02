Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVIBFz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVIBFz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 01:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVIBFz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 01:55:57 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20099 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1030202AbVIBFz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 01:55:56 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Greg KH <greg@kroah.com>
Subject: Re: i2c via686a.c: save at least 0.5k of space by long v[256] -> u16 v[256]
Date: Fri, 2 Sep 2005 08:54:37 +0300
User-Agent: KMail/1.8.2
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
References: <200509010910.14824.vda@ilport.com.ua> <20050901155915.GB1235@kroah.com>
In-Reply-To: <20050901155915.GB1235@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dk+FDMtE/upEjWK"
Message-Id: <200509020854.37192.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_dk+FDMtE/upEjWK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 01 September 2005 18:59, Greg KH wrote:
> On Thu, Sep 01, 2005 at 09:10:14AM +0300, Denis Vlasenko wrote:
> > Not tested, but it's rather obvious.
> 
> Except you forgot a "Signed-off-by:" line...
> 
> > --- linux-2.6.12.src/drivers/i2c/chips/via686a.c.orig	Sun Jun 19 16:10:10 2005
> > +++ linux-2.6.12.src/drivers/i2c/chips/via686a.c	Tue Aug 30 00:21:39 2005
> > @@ -205,7 +205,7 @@ static inline u8 FAN_TO_REG(long rpm, in
> >   but the function is very linear in the useful range (0-80 deg C), so 
> >   we'll just use linear interpolation for 10-bit readings.)  So, tempLUT 
> >   is the temp at via register values 0-255: */
> > -static const long tempLUT[] =
> > +static const int16_t tempLUT[] =
> 
> int16_t is not a proper kernel type.  Do you really mean s16 instead?

Ok. Please be informed that there are lots of intNN_t's in i2c dir tho...

> Care to redo this?

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_dk+FDMtE/upEjWK
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="via686a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via686a.patch"

--- linux-2.6.12.src/drivers/i2c/chips/via686a.c.orig	Sun Jun 19 16:10:10 2005
+++ linux-2.6.12.src/drivers/i2c/chips/via686a.c	Tue Aug 30 00:21:39 2005
@@ -205,7 +205,7 @@ static inline u8 FAN_TO_REG(long rpm, in
  but the function is very linear in the useful range (0-80 deg C), so 
  we'll just use linear interpolation for 10-bit readings.)  So, tempLUT 
  is the temp at via register values 0-255: */
-static const long tempLUT[] =
+static const s16 tempLUT[] =
     { -709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
 	    -503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
 	    -362, -350, -339, -327, -316, -305, -295, -285, -275, -265,

--Boundary-00=_dk+FDMtE/upEjWK--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbUKEWYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbUKEWYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUKEWYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:24:24 -0500
Received: from gateway.penguincomputing.com ([64.243.132.186]:63131 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S261180AbUKEWYL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:24:11 -0500
X-Mda: Mail::Internet Mail::Sendmail Sendmail +mmhack 1.1 on Linux
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       phil@netroedge.com
User-Agent: Mutt/1.4.1i
Subject: Re: [PATCH] 2.6 lm85.c driver update
In-Reply-To: <20041105214841.GI1750@kroah.com>
Content-Disposition: inline
Date: Fri, 5 Nov 2004 14:25:46 -0800
Message-Id: <20041105222546.GA31538@penguincomputing.com>
References: <20041004200943.GE22290@penguincomputing.com>
 <20041019222920.GJ9521@kroah.com>
 <20041025203610.GA19053@penguincomputing.com>
 <20041025225959.6026626f.khali@linux-fr.org>
 <20041025220526.GC19053@penguincomputing.com>
 <20041105214841.GI1750@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Greg KH <greg@kroah.com>
Content-Transfer-Encoding: 8BIT
From: Justin Thiessen <jthiessen@penguincomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 01:48:41PM -0800, Greg KH wrote:
> On Mon, Oct 25, 2004 at 03:05:26PM -0700, Justin Thiessen wrote:
> > On Mon, Oct 25, 2004 at 10:59:59PM +0200, Jean Delvare wrote:
> > > > > Hm, there are a number of rejects in this patch.  Care to resync up
> > > > > with the next kernel release and resend this?
> > > > 
> > > > Ok, try this:
> > > > 
> > > > signed off by:  Justin Thiessen  <jthiessen@penguincomputing.com>
> > > > 
> > > > patch for kernel 2.6.X lm85 driver follows:

<snip>

> Applied, thanks.
> 
> But now I get the following build warnings:
> 
> drivers/i2c/chips/lm85.c:220: warning: 'SMOOTH_TO_REG' defined but not used
> drivers/i2c/chips/lm85.c:236: warning: 'SPINUP_TO_REG' defined but not used
> 
> Care to send me a patch to fix them up?

Ok.

Justin Thiessen

Signed off by Justin Thiessen <jthiessen@penguincomputing.com>

-------

--- linux-2.6.10-rc1/drivers/i2c/chips/lm85.c.orig	2004-11-04 20:30:08.340770952 -0800
+++ linux-2.6.10-rc1/drivers/i2c/chips/lm85.c	2004-11-04 20:25:25.354791360 -0800
@@ -212,38 +212,6 @@ static int RANGE_TO_REG( int range )
  *       MSB (bit 3, value 8).  If the enable bit is 0, the encoded value
  *       is ignored, or set to 0.
  */
-static int lm85_smooth_map[] = {  /* .1 sec */
-		350, 176, 118,  70,  44,   30,   16,    8
-/*    35.4 *    1/1, 1/2, 1/3, 1/5, 1/8, 1/12, 1/24, 1/48  */
-	};
-static int SMOOTH_TO_REG( int smooth )
-{
-	int i;
-
-	if( smooth <= 0 ) { return 0 ; }  /* Disabled */
-	for( i = 0 ; i < 7 ; ++i )
-		if( smooth >= lm85_smooth_map[i] )
-			break ;
-	return( (i & 0x07) | 0x08 );
-}
-#define SMOOTH_FROM_REG(val) ((val)&0x08?lm85_smooth_map[(val)&0x07]:0)
-
-/* These are the fan spinup delay time encodings */
-static int lm85_spinup_map[] = {  /* .1 sec */
-		0, 1, 2, 4, 7, 10, 20, 40
-	};
-static int SPINUP_TO_REG( int spinup )
-{
-	int i;
-
-	if( spinup >= lm85_spinup_map[7] ) { return 7 ; }
-	for( i = 0 ; i < 7 ; ++i )
-		if( spinup <= lm85_spinup_map[i] )
-			break ;
-	return( i & 0x07 );
-}
-#define SPINUP_FROM_REG(val) (lm85_spinup_map[(val)&0x07])
-
 /* These are the PWM frequency encodings */
 static int lm85_freq_map[] = { /* .1 Hz */
 		100, 150, 230, 300, 380, 470, 620, 940


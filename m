Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbTFVBOM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 21:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbTFVBOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 21:14:12 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:2574 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id S265338AbTFVBOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 21:14:10 -0400
Date: Sat, 21 Jun 2003 19:28:12 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: Re: AIC7(censored) card gone wild?
Message-ID: <962370000.1056245292@aslan.scsiguy.com>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780E040C95@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780E040C95@orsmsx116.jf.intel.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Justin, list ...
> 
> I have a 2xPIII 797 Mhz with an AIC-7899P U160/m; I have 
> been running it under 2.5.66 since it was released, always 
> using the AIC7XXXX driver (new one).
> 
> However, suddenly something weird happened; since one week
> ago, I get panics (in the serial console) like
> the one attached (milikk.panic.txt) always caused or having
> an rsync process as current (rsync is used for backup).
> 
> I also noticed that at about the same time I started to
> get got those panics, I get the following when booting 
> the kernel:

I'm not sure what may have changed in your configuration to
make these problems start, but there is one recent fix that
may apply to your problem.  I do not know if this will apply
to the 6.2.28 driver version you are using since it is based
on the latest driver release from here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

Here's the patch:

--
Justin

==== //depot/aic7xxx/aic7xxx/aic7xxx.c#134 (ktext) ====

@@ -37,7 +37,7 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.c#133 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.c#134 $
  *
  * $FreeBSD$
  */
@@ -1469,7 +1469,7 @@
 				 * current connection, so we must
 				 * leave it on while single stepping.
 				 */
-				ahc_outb(ahc, SIMODE1, ENBUSFREE);
+				ahc_outb(ahc, SIMODE1, simode1 & ENBUSFREE);
 			else
 				ahc_outb(ahc, SIMODE1, 0);
 			ahc_outb(ahc, CLRINT, CLRSCSIINT);


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262635AbSI0Wn6>; Fri, 27 Sep 2002 18:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbSI0Wn6>; Fri, 27 Sep 2002 18:43:58 -0400
Received: from magic.adaptec.com ([208.236.45.80]:31483 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262633AbSI0Wnz>; Fri, 27 Sep 2002 18:43:55 -0400
Date: Fri, 27 Sep 2002 16:48:54 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Patrick Mansfield <patmans@us.ibm.com>
cc: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing
 file  transfers
Message-ID: <2698376224.1033166934@aslan.btc.adaptec.com>
In-Reply-To: <20020927152842.A18038@eng2.beaverton.ibm.com>
References: <200209271721.g8RHLTn05231@localhost.localdomain>
 <2628736224.1033160295@aslan.btc.adaptec.com>
 <20020927143841.A17108@eng2.beaverton.ibm.com>
 <2668366224.1033164502@aslan.btc.adaptec.com>
 <20020927152842.A18038@eng2.beaverton.ibm.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========3294902874=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========3294902874==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> I turned on the debug flags, there were a bunch of odd messages
> in there, but otherwise it seems to be working fine. My .config
> has the following AIC config options:

<sigh>
I always run with debugging turned on with the message flags enabled,
so I missed this in my testing.  I just updated the tarfile.  The
following patch is all you need to shut the driver up.

--
Justin

--==========3294902874==========
Content-Type: text/plain; charset=us-ascii; name=diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=diff; size=1375

Change 1419 by gibbs@bitkeeper-linux-2.5 on 2002/09/27 16:44:04

	Add a missing pair of curly braces to a conditional debug
	statement.  This ensures that debug code doesn't trigger if
	it isn't enabled. <blush>

Affected files ...

... //depot/aic7xxx/aic7xxx/aic7xxx.c#80 edit

Differences ...

==== //depot/aic7xxx/aic7xxx/aic7xxx.c#80 (ktext) ====

***************
*** 37,43 ****
   * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
   * POSSIBILITY OF SUCH DAMAGES.
   *
!  * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.c#79 $
   *
   * $FreeBSD$
   */
--- 37,43 ----
   * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
   * POSSIBILITY OF SUCH DAMAGES.
   *
!  * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.c#80 $
   *
   * $FreeBSD$
   */
***************
*** 2475,2483 ****
  			panic("HOST_MSG_LOOP interrupt with no active message");
  
  #ifdef AHC_DEBUG
! 		if ((ahc_debug & AHC_SHOW_MESSAGES) != 0)
  			ahc_print_devinfo(ahc, &devinfo);
  			printf("INITIATOR_MSG_OUT");
  #endif
  		phasemis = bus_phase != P_MESGOUT;
  		if (phasemis) {
--- 2475,2484 ----
  			panic("HOST_MSG_LOOP interrupt with no active message");
  
  #ifdef AHC_DEBUG
! 		if ((ahc_debug & AHC_SHOW_MESSAGES) != 0) {
  			ahc_print_devinfo(ahc, &devinfo);
  			printf("INITIATOR_MSG_OUT");
+ 		}
  #endif
  		phasemis = bus_phase != P_MESGOUT;
  		if (phasemis) {

--==========3294902874==========--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268274AbUIPQhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268274AbUIPQhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268158AbUIPQfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:35:54 -0400
Received: from ms-smtp-03-qfe0.socal.rr.com ([66.75.162.135]:184 "EHLO
	ms-smtp-03-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S268472AbUIPQeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:34:20 -0400
Date: Thu, 16 Sep 2004 09:30:29 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: "Oliver M. Bolzer" <oliver@fakeroot.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qla2xxx: frequent total lockups (2.6.8, 2.6.9-rc{1-mm5,2})
Message-ID: <20040916163029.GA14441@praka.san.rr.com>
Mail-Followup-To: Andrew Vasquez <andrew.vasquez@qlogic.com>,
	"Oliver M. Bolzer" <oliver@fakeroot.net>,
	linux-kernel@vger.kernel.org
References: <20040915231657.GA2005@magi.fakeroot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915231657.GA2005@magi.fakeroot.net>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.9-rc1-mm2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Oliver M. Bolzer wrote:

> I'm currently setting up a new Dual Opteron box (Tyan Transport
> GX28) equipped with a QLogic QLA2340 fibre channel HBA.
> 
> As soon as there is I/O load on the HBA, I start seeing
> 

Could you provide some details on the type of I/O load?  

> I've tested and reproduced the error on the following kernels, all
> compiled for x86_64.
> 2.6.8.1
> 2.6.9-rc1-mm5 (with dma_fixups patch posted by Andrew Vasquez on 13.9)
> 2.6.9-rc2 
> 

For another datapoint, did you have any problems with earlier driver
versions (pre b21)?  2.6.8.1 had b14k...

> Without any I/O on the HBA (nothing mounted), I have yet to capture a 
> crash, but the driver still ocasionally reports 
> qla2300 0000:01:03.0: cmd_timeout: LOST command state = 0x6
> 
> Any help would be greatly appreciated. If there are any tests I could 
> run, just let me know.
> 

Hmm, could you enable some additional debug settings in the driver:


  in qla_settings.h:

    modify the following line:

	#define DEBUG_QLA2100           0       /* For Debug of qla2x00 */

    to read as:

	#define DEBUG_QLA2100           1       /* For Debug of qla2x00 */


  and in qla_dbg.h

    modify the following line:

	/* #define QL_DEBUG_LEVEL_2  */ /* Output error msgs to COM1 */

    to read as:

	#define QL_DEBUG_LEVEL_2   /* Output error msgs to COM1 */

Rerun your test, then forward over the log.


Regards,
Andrew Vasquez


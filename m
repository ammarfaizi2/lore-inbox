Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262283AbREXVFU>; Thu, 24 May 2001 17:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262286AbREXVFK>; Thu, 24 May 2001 17:05:10 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:733 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262283AbREXVEw>;
	Thu, 24 May 2001 17:04:52 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105242104.OAA29671@csl.Stanford.EDU>
Subject: [CHECKER] use of floating point in 2.4.4 and 2.4.4-ac8
To: linux-kernel@vger.kernel.org
Date: Thu, 24 May 2001 14:04:45 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

These check the rule "DO NOT USE FLOATING POINT IN THE KERNEL" on the 
2.4.4 and 2.4.4-ac8 releases.  There were 10 errors in all:
  		2.4.4-specific errors 	  = 8
  		Common errors 		  = 2

	------------------------------------------------------
	BUG Count   |	File Name
	------------------------------------------------------
	8	    |	drivers/video/sis/sis_main.c
	2	    |	drivers/video/sgivwfb.c


Dawson


Boilerplate disclaimer:
        - this is part of a one-time large batch of errors.  In the future,
          we'll send out incremental bug reports along with a pointer to
          the bug database on our website.

        - as always, bugs may not be errors --- we have inspected the
          error logs to counter this.

        - bugs may be missing in one distribution versus the other because
          we did not compile that file (or failed to fully compile it).
          It can be worthwhile to cross check important bugs to make sure
          they've been killed.

        - sorted roughly by severity and ease-of-diagnosis.  The highest
          ranked bugs are "SECURITY" which (in most of the examples) 
          are primarily denial-of-service vulnerabilities where the user
          could trigger the bug when they canted to.  Ease-of-diagnosis
          is currently crude: we rank LOCAL errors over GLOBAL (GLOBAL
          require looking at call chains) and then distance between
          error source and manifestation as the next (closer is better)


	- if a version if one of the version has no errors specific to it,
	  this can just be because we did not inspect all the error reports.
	  These are typically from checkers that required some inter-function
	  inspection.  If you are interested in these errors, send us mail,,
	  and we can send you the unispected file.

############################################################
# 2.4.4 specific errors

---------------------------------------------------------
[BUG]  What is the right way to count these?  Probably each unique var
       and each uniq expr that counted vars don't appear in?
/u2/engler/mc/oses/linux/2.4.4/drivers/video/sis/sis_main.c:589:crtc_to_var: ERROR:FLOAT: cannot use fp in kernel

	VT <<= 1;
	HT = (HT + 5) * 8;

	hrate = (double) ivideo.refresh_rate * (double) VT / 2;
	drate = hrate * HT;

Error --->
	var->pixclock = (u32) (1E12 / drate);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/video/sis/sis_main.c:777:do_set_var: ERROR:FLOAT: cannot use fp in kernel

	if (!htotal || !vtotal) {
		DPRINTK("Invalid 'var' Information!\n");
		return 1;
	}


Error --->
	drate = 1E12 / var->pixclock;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/video/sis/sis_main.c:778:do_set_var: ERROR:FLOAT: cannot use fp in kernel

		DPRINTK("Invalid 'var' Information!\n");
		return 1;
	}

	drate = 1E12 / var->pixclock;

Error --->
	hrate = drate / htotal;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/video/sis/sis_main.c:779:do_set_var: ERROR:FLOAT: cannot use fp in kernel

		return 1;
	}

	drate = 1E12 / var->pixclock;
	hrate = drate / htotal;

Error --->
	ivideo.refresh_rate = (unsigned int) (hrate / vtotal * 2 + 0.5);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/video/sis/sis_main.c:760:do_set_var: ERROR:FLOAT: cannot use fp in kernel

	    var->left_margin + var->xres + var->right_margin +
	    var->hsync_len;
	unsigned int vtotal =
	    var->upper_margin + var->yres + var->lower_margin +
	    var->vsync_len;

Error --->
	double drate = 0, hrate = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/video/sis/sis_main.c:587:crtc_to_var: ERROR:FLOAT: cannot use fp in kernel


	VT += 2;
	VT <<= 1;
	HT = (HT + 5) * 8;


Error --->
	hrate = (double) ivideo.refresh_rate * (double) VT / 2;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/video/sis/sis_main.c:403:crtc_to_var: ERROR:FLOAT: cannot use fp in kernel

{
	u16 VRE, VBE, VRS, VBS, VDE, VT;
	u16 HRE, HBE, HRS, HBS, HDE, HT;
	u8 uSRdata, uCRdata, uCRdata2, uCRdata3, uMRdata;
	int A, B, C, D, E, F, temp;

Error --->
	double hrate, drate;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/video/sis/sis_main.c:588:crtc_to_var: ERROR:FLOAT: cannot use fp in kernel

	VT += 2;
	VT <<= 1;
	HT = (HT + 5) * 8;

	hrate = (double) ivideo.refresh_rate * (double) VT / 2;

Error --->
	drate = hrate * HT;

############################################################
# Errors common to both

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/video/sgivwfb.c:730:sgivwfb_set_var: ERROR:FLOAT: cannot use fp in kernel

  var->green.msb_right = 0;
  var->blue.msb_right = 0;
  var->transp.msb_right = 0;

  /* set video timing information */

Error --->
  var->pixclock = (__u32)(1.0e+9/(float)timing->cfreq);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/video/sgivwfb.c:663:sgivwfb_set_var: ERROR:FLOAT: cannot use fp in kernel

  if (min_mode == DBE_VT_SIZE)
    return -EINVAL;             /* Resolution to high */

  /* XXX FIXME - should try to pick best refresh rate */
  /* for now, pick closest dot-clock within 3MHz*/

Error --->
  req_dot = (int)((1.0e3/1.0e6) / (1.0e-12 * (float)var->pixclock));


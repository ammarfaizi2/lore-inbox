Return-Path: <linux-kernel-owner+w=401wt.eu-S1751732AbXAUW1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbXAUW1T (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 17:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbXAUW1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 17:27:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:59221 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751729AbXAUW1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 17:27:18 -0500
X-Authenticated: #5039886
Date: Sun, 21 Jan 2007 23:27:14 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Chr <chunkeey@web.de>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070121222714.GA2473@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
	Chr <chunkeey@web.de>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-kernel@vger.kernel.org, htejun@gmail.com,
	jens.axboe@oracle.com, lwalton@real.com
References: <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca> <200701202332.58719.chunkeey@web.de> <45B2C6E1.9000901@shaw.ca> <45B2DF43.8080304@garzik.org> <20070121045437.GA7387@atjola.homenet> <45B30A98.3030206@shaw.ca> <20070121083618.GA2434@atjola.homenet> <20070121184032.GA3220@atjola.homenet> <45B3C5C9.4010007@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45B3C5C9.4010007@shaw.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.21 13:58:01 -0600, Robert Hancock wrote:
> Björn Steinbrink wrote:
> >All kernels were bad using that approach. So back to square 1. :/
> >
> >Björn
> >
> 
> OK guys, here's a new patch to try against 2.6.20-rc5:
> 
> Right now when switching between ADMA mode and legacy mode (i.e. when 
> going from doing normal DMA reads/writes to doing a FLUSH CACHE) we just 
> set the ADMA GO register bit appropriately and continue with no delay. 
> It looks like in some cases the controller doesn't respond to this 
> immediately, it takes some nanoseconds for the controller's status 
> registers to reflect the change that was made. It's possible that if we 
> were trying to issue commands during this time, the controller might not 
> react properly. This patch adds some code to wait for the status 
> register to change to the state we asked for before continuing.

Just got two exceptions with your patch, none of the debug messages were
issued.

Björn

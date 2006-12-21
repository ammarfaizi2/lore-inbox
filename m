Return-Path: <linux-kernel-owner+w=401wt.eu-S1422764AbWLUGiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWLUGiH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422765AbWLUGiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:38:07 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:36314 "HELO
	smtp101.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422764AbWLUGiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:38:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ZHNlZkTdLERipYzKU2gzhL0y+49++XkU1FzUHjzQ/akG5H9lFSFyyrkkaoaf4fQbAJGEptL6iuDz87Rfv6a4EHpHLA4g72yrbGCYVJCKvEB7JY3ZWBG77HIjYLtL2gV1cJXEXgi5c6Iz8NSa1sGlilgnoDyHib+qs3BYopvGLyk=  ;
X-YMail-OSG: 8YABeWsVM1kBjNtINCXEpptQszCPbONdBQ9daZ.qG2fScZiict94zbAezX.z8HcPkSctYOr2jM2ZqK9Zknj_.M7yD0KsZoVyqKzvNVky8ht9JtO3TvKxRn3qpfk0Z_tZTYl7C6517DSsxtfdDL.3TF6uT_V61KQUeAKJWnLrhjS.0BqBvX4Whww5Ngvm
From: David Brownell <david-b@pacbell.net>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Network drivers that don't suspend on interface down
Date: Wed, 20 Dec 2006 21:25:10 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Matthew Garrett <mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202125.10865.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, this reminds me of a thread from last summer, following up on
some PM discussions at OLS.  Thread "Runtime power management for
network interfaces", at the end of July.


> 2) Network device infrastructure should make it easier for devices:
>     bring interface down on suspend and bring it up after resume
>     (if it was running when suspended). This would allow many devices to
>     have no suspend/resume hook; except those that have some better power
>     control over hardware.

The _intent_ of the class suspend() and resume() methods is to let
infrastructure (the network stack was explicitly mentioned!) handle
pretty much everything except putting the hardware in low power
modes ... which last step might, for PCI devices at least, most
naturally be done in suspend_late().  That way it'd be decoupled
cleanly from anything else.

Now, I recently tried refreshing a patch that used those class
suspend() and resume() methods, and for some reason they're not
getting called.  I believe they used to get called, although it's
true their parameter wasn't very useful ... it was called with the
underlying device, not the class_device holding state that the
class driver manages.

I just wanted to point out that yes, this ground has been covered
before, with some agreement on that approach.  It'd be good to see
it pursued.  :)

- Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVKQKxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVKQKxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 05:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVKQKxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 05:53:19 -0500
Received: from aun.it.uu.se ([130.238.12.36]:56212 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750755AbVKQKxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 05:53:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17276.24851.194332.590736@alkaid.it.uu.se>
Date: Thu, 17 Nov 2005 11:53:07 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH:  Fix poor pointer math in devinet_sysctl_register
In-Reply-To: <20051116232345.GA872@cosmic.amd.com>
References: <20051116232345.GA872@cosmic.amd.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse writes:
 > This patch fixes pointer math that under certain circumstances, results
 > in really bad pointers. This was encountered on a system compiled for i486, so
 > other compilers may differ, but I don't think it hurts anyone.
 > 
 > Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
 > ---
 > 
 >  net/ipv4/devinet.c |    2 +-
 >  1 files changed, 1 insertions(+), 1 deletions(-)
 > 
 > diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
 > index 4ec4b2c..7585fce 100644
 > --- a/net/ipv4/devinet.c
 > +++ b/net/ipv4/devinet.c
 > @@ -1454,7 +1454,7 @@ static void devinet_sysctl_register(stru
 >  		return;
 >  	memcpy(t, &devinet_sysctl, sizeof(*t));
 >  	for (i = 0; i < ARRAY_SIZE(t->devinet_vars) - 1; i++) {
 > -		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
 > +		t->devinet_vars[i].data += (int)((char *)p - (char *)&ipv4_devconf);
 >  		t->devinet_vars[i].de = NULL;
 >  	}

This is the same code which broke due to a known gcc-4.0.0 bug:
<http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21173>. If you're
indeed using gcc-4.0.0, then it's time to upgrade.

/Mikael

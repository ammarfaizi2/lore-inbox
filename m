Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVC1SCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVC1SCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVC1SAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 13:00:40 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:35773 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261986AbVC1R4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:56:18 -0500
Date: Mon, 28 Mar 2005 19:56:15 +0200
To: 20050323135317.GA22959@roonstrasse.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Message-ID: <20050328175614.GG943@vanheusden.com>
References: <20050328172820.GA31571@linux.ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328172820.GA31571@linux.ensimag.fr>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Sat Mar 26 23:38:20 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The memory limits aren't good enough either: if you set them low
> > enough that memory-forkbombs are unperilous for
> > RLIMIT_NPROC*RLIMIT_DATA, it's probably too low for serious
> > applications.
> yes, if you want to run application like openoffice.org you need at
> least 200Mo. If you want that your system is usable, you need at least 40 process per user. So 40*200 = 8Go, and it don't think you have all this memory...
> I think per user limit could be a solution.
> attached a small fork-memory bombing.
> Matthieu
> int main()
> {
> 	while(1){
> 		while(fork()){
> 			malloc(1);
> 		}
> 	}
> }

Imporved version:

int main()
{
	while(1) {
		while(fork()) {
			char *dummy = (char *)malloc(1);
			*dummy = 1;
		}
	}
}


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

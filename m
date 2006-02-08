Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWBHM4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWBHM4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWBHM4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:56:35 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:48637 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030356AbWBHM4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:56:34 -0500
Date: Wed, 8 Feb 2006 13:35:41 +0100
From: Holger Eitzenberger <holger@my-eitzenberger.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       kaber@trash.net
Subject: Re: [patch 6/6] [NETFILTER]: Fix another crash in ip_nat_pptp (CVE-2006-0037)
Message-ID: <20060208123541.GA6004@kruemel.my-eitzenberger.de>
Mail-Followup-To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Dave Jones <davej@redhat.com>,
	Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk, kaber@trash.net
References: <20060128015840.722214000@press.kroah.org> <20060128021835.GG10362@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128021835.GG10362@kroah.com>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8548cd0e00552bb75411ff34ad15700a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 06:18:35PM -0800, Greg KH wrote:

>  	DEBUGP("altering call id from 0x%04x to 0x%04x\n",
> -		ntohs(*cid), ntohs(new_callid));
> +		ntohs(*(u_int16_t *)pptpReq + cid_off), ntohs(new_callid));

Note that this fix introduces another bug in the above use DEBUGP
statement, as there is (u_int16_t *) ptr arithmetic used, whereas
cid_off is a byte offset.

A fix for that was send a few weeks ago on netfilter-devel.

/holger


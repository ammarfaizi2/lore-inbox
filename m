Return-Path: <linux-kernel-owner+w=401wt.eu-S932796AbWL0NYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbWL0NYS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 08:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWL0NYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 08:24:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55975 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817AbWL0NYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 08:24:17 -0500
Date: Wed, 27 Dec 2006 13:24:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Karel Zak <kzak@redhat.com>,
       linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>
Subject: Re: util-linux: orphan
Message-ID: <20061227132413.GA3405@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Karel Zak <kzak@redhat.com>, linux-kernel@vger.kernel.org,
	Henne Vogelsang <hvogel@suse.de>, Olaf Hering <olh@suse.de>
References: <20061109224157.GH4324@petra.dvoda.cz> <20061218071737.GA5217@petra.dvoda.cz> <200612270346.10699.arnd@arndb.de> <4591E3BB.9070806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4591E3BB.9070806@zytor.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26, 2006 at 07:08:43PM -0800, H. Peter Anvin wrote:
> That's a pretty silly statement.  The real issue is that any library 
> needed by binaries in /bin or /sbin should live in /lib, not /usr/lib.

Well, there's a real treat here - lots of shared libraries mean
mount is rendered unusable when they are not available for some reason.
And there could be lots of reasons for this.  We've seen selinux mislabeling
with a fedoro-ish box in the lab, there is the possibility of unintentional
ABI breaks and so on and so on.

Then again using shared libraries has  big advtantags over duplicating all
the code, so I wouldn't want to say I'm totally against it.  As mount
only needs the various libraries for it's non-core features what about
dlopen()ing those libraries?  That way a messed up system at least has the
bare mount functionality available.


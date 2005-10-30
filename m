Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVJ3Lg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVJ3Lg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 06:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVJ3Lg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 06:36:27 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:36480 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932067AbVJ3Lg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 06:36:27 -0500
Date: Sun, 30 Oct 2005 12:36:51 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
Message-ID: <20051030113651.GA1780@uio.no>
References: <20051030023557.GA7798@uio.no> <20051030101148.GA18854@outpost.ds9a.nl> <20051030104527.GB32446@uio.no> <20051030110021.GA19680@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051030110021.GA19680@outpost.ds9a.nl>
X-Operating-System: Linux 2.6.14-rc5 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.8 (--)
X-Spam-Report: Status=No hits=-2.8 required=5.0 tests=ALL_TRUSTED version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:00:21PM +0100, bert hubert wrote:
> Ok - no further ideas then. I think people would be interested in the strace
> you describe as 'garbage'.

The strace is a little big (1.5GB), but sure, people can have it if they're
interested. OTOH, I just noticed that syslogd shows:

  Oct 30 09:55:50 cirkus named[13364]: errno2result.c:109: unexpected error:
  Oct 30 09:55:50 cirkus named[13364]: unable to convert errno to isc_result: 14: Bad address
  Oct 30 09:55:50 cirkus named[13364]: UDP client handler shutting down due to fatal receive error: unexpected error

...and after that, everything seems to crash and burn. The related strace
call is:

  [pid 13365] recvmsg(22, 0x561329b0, 0)  = -1 EFAULT (Bad address)

Might this be a BIND bug instead? In that case, why doesn't it show up with
2.6.11.9? I've restarted BIND now without NPTL, to see if it might be
thread-related.

> Alternatively, give PowerDNS 2.9.19 a try :-) It reads most bind named.conf
> files directly, especially if you don't do views, dynamic updates etc.

We're not going to change DNS server software anytime soon on our production
servers, but thanks for the tip :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751808AbWEFBLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWEFBLW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 21:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWEFBLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 21:11:22 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:12745 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751808AbWEFBLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 21:11:21 -0400
Message-ID: <346877876.18033@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 6 May 2006 09:11:25 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060506011125.GA9099@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>
References: <346556235.24875@ustc.edu.cn> <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org> <Pine.LNX.4.64.0605031816480.13777@cuia.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605031816480.13777@cuia.boston.redhat.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 06:20:29PM -0400, Rik van Riel wrote:
> Why not simply read everything in a whole file at a time
> at boot time, while we still have enough free memory ?

Sure it helps, though may be unnecessary once we can rely on userspace
pre-caching tools to do it in a more accurate and efficient way.

The main concern would be inter-file/inter-buffer readahead.
I have some data to support it:

% wc -l hda* startup.files
 1743 hda2_buffers      <== my /
 335 hda3_buffers       <== my /home
 1130 startup.files
 3208 total

The above cache sizes sum up to ~110MB, so it's about 36KB per seek.

Thanks,
Wu

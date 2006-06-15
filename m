Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWFOAkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWFOAkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 20:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWFOAkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 20:40:14 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:41098 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751262AbWFOAkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 20:40:12 -0400
Message-ID: <350332007.09368@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 15 Jun 2006 08:40:34 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Bernard Blackham <b-lkml@blackham.com.au>
Cc: linux-kernel@vger.kernel.org, Lubos Lunak <l.lunak@suse.cz>,
       Dirk Mueller <dmueller@suse.de>, Badari Pulavarty <pbadari@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] the /proc/filecache interface
Message-ID: <20060615004034.GA5013@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <fengguang.wu@gmail.com>,
	Bernard Blackham <b-lkml@blackham.com.au>,
	linux-kernel@vger.kernel.org, Lubos Lunak <l.lunak@suse.cz>,
	Dirk Mueller <dmueller@suse.de>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>
References: <20060612075130.GA5432@mail.ustc.edu.cn> <20060614153837.GA16601@ucc.gu.uwa.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614153837.GA16601@ucc.gu.uwa.edu.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard,

On Wed, Jun 14, 2006 at 11:38:37PM +0800, Bernard Blackham wrote:
> I haven't been following this closely, so I apologise if I'm out of
> my depth. It would be a useful add-on to be able to use this
> interface to force something _out_ of the page cache also. For
> example, for performance tests, or selectively ditching pages before
> software suspending.

Sure we can add more related commands into it.

For example, the functions in fs/drop_caches.c are well suited for
this interface. The current sysctl interface is a quick hacking:

/* A global variable is a bit ugly, but it keeps the code simple */
int sysctl_drop_caches;

The following scheme may be more reasonable:

# echo -n "drop files" > /proc/filecache
# echo -n "drop slabs" > /proc/filecache

As for the "selectively ditching pages" function, my original scheme
is to
        - query /proc/filecache to answer the question of "which pages
          are cached, and their status(referenced/active etc.)"
        - run "fadvise filename page-offset pages" to ditch pages
Do you think it as convenient?

Thanks,
Wu

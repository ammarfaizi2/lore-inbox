Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWJBEHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWJBEHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 00:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWJBEHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 00:07:33 -0400
Received: from 1wt.eu ([62.212.114.60]:1540 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S932284AbWJBEHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 00:07:32 -0400
Date: Mon, 2 Oct 2006 05:35:31 +0200
From: Willy Tarreau <w@1wt.eu>
To: Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
Message-ID: <20061002033531.GA5050@1wt.eu>
References: <20061002033511.GB12695@zimmer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002033511.GB12695@zimmer>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 10:35:11PM -0500, Drew Scott Daniels wrote:
> ppmd, also in Debian had better compression than lzma. PAQ8i has even
> better compression, but isn't in Debian. See the maximumcompression web
> site or other archive comparison tests.

Interesting. But I suspect that you have not checked the compression time.
PAQ8I for instance is between 100 and 300 times SLOWER than bzip2 to achieve
about 30% smaller ! Given that the kernel already takes a very long time to
compress with bzip2, it would take several hours to compress it with such
tools. While they're very interesting proofs of concept for compression
research, they're not suited to any real world usage !

> The pace of compression algorithm development is high enough that I'd
> suggest that the bar be placed quite high before switching to a new
> compression format that's not reverse compatible.

At least, ppmd takes the same time as bzip2 to achieve about 12% better
compression. But I don't think it justifies a switch.

> For those interested, I'm working on publishing a proof of concept that 
> can make most tarballs compress better. About 2-3% better in my tests 
> with bzip2/gzip on the Linux kernel source code.

A lot of improvement can be made in tar to compress better archive with
large number of small files such as the kernel. You just have to see the
difference in archive size depending on the base directory name. If you
come up with something really interesting which does not alter the output
format nor the compression time, it might get a place in the git-tar-tree
command. But IMHO, it would me more interesting to further reduce patches
size than tarballs size, since patches might be downloaded far more often.

Regards,
Willy


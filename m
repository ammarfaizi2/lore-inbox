Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSH0NLR>; Tue, 27 Aug 2002 09:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315925AbSH0NLR>; Tue, 27 Aug 2002 09:11:17 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:20484 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315919AbSH0NLQ>; Tue, 27 Aug 2002 09:11:16 -0400
Date: Tue, 27 Aug 2002 14:15:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: kernel@bonin.ca, aia21@cantab.net, linux-kernel@vger.kernel.org
Subject: Re: Loop devices under NTFS
Message-ID: <20020827141530.A25956@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>, kernel@bonin.ca,
	aia21@cantab.net, linux-kernel@vger.kernel.org
References: <200208271240.FAA04753@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208271240.FAA04753@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Aug 27, 2002 at 05:40:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 05:40:52AM -0700, Adam J. Richter wrote:
> 	There are only a few file systems that provide writable files
> without aops->{prepare,commit}_write.  I think they are just tmpfs,
> ntfs and intermezzo.  If all file systems that provided writable files
> could be expected to provide {prepare,commit}_write, I could eliminate
> the file_ops->{read,write} code from loop.c.

This is the wrong level of abstraction.  There is no reason why a filesystem
has to use the pagecache at all.

Note that there is a more severe bug in loop.c:  it's abuse of
do_generic_file_read.  

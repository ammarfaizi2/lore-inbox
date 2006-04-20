Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWDTRTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWDTRTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWDTRTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:19:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37254 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751070AbWDTRTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:19:02 -0400
Date: Thu, 20 Apr 2006 18:18:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com, sct@redhat.com,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] FS-Cache: Avoid ENFILE checking for kernel-specific open files
Message-ID: <20060420171857.GA21659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, steved@redhat.com, sct@redhat.com, aviro@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
	nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 05:59:33PM +0100, David Howells wrote:
> Make it possible to avoid ENFILE checking for kernel specific open files, such
> as are used by the CacheFiles module.
> 
> After, for example, tarring up a kernel source tree over the network, the
> CacheFiles module may easily have 20000+ files open in the backing filesystem,
> thus causing all non-root processes to be given error ENFILE when they try to
> open a file, socket, pipe, etc..

No, just increase the limit.  The whole point of the limit is to avoid resource
exaustion.  A file doesn't use any less ressources just becuase it's opened
from kernelspace.  In doubt increase the limit or even the default limit.


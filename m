Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTD0IwI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 04:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbTD0IwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 04:52:05 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:31180 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263179AbTD0IwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 04:52:04 -0400
Date: Sun, 27 Apr 2003 11:04:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re:  Swap Compression
Message-ID: <20030427090418.GB6961@wohnheim.fh-wedel.de>
References: <200304251848410590.00DEC185@smtp.comcast.net> <20030426091747.GD23757@wohnheim.fh-wedel.de> <200304261148590300.00CE9372@smtp.comcast.net> <20030426160920.GC21015@wohnheim.fh-wedel.de> <200304262224040410.031419FD@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304262224040410.031419FD@smtp.comcast.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 April 2003 22:24:04 -0400, rmoser wrote:
> 
> So what's the best way to do this?  I was originally thinking like this:
> 
> Grab some swap data
> Stuff it into fcomp_push()
> When you have 100k of data, seal it up
> Write that 100k block

I would like something like this:

/*	fox_compress
 *	@input: Pointer to uncompressed data
 *	@output: Pointer to buffer
 *	@inlen: Size of uncompressed data
 *	@outlen: Size of the buffer
 *
 *	Return:
 *	0 on successful compression
 *	-Esomething on error
 *
 *	Side effects:
 *	Output buffer is filled with random data after an error
 *	condition or the compressed input data on success.
 *	outlen remains unchanged on error and holds the compressed
 *	data size on success
 *
 *	If the output buffer is too small, this is an error.
 */
int fox_compress(unsigned char *input, unsigned char *output,
		uint32_t inlen, uint32_t *outlen);

/*	fox_decompress
 *	see above, basically
 */
int fox_decompress(unsigned char *input, unsigned char *output,
		uint32_t inlen, uint32_t *outlen);

Then the mm code can pick any useful size for compression.

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra

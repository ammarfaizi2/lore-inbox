Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTFDFkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTFDFkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:40:11 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:26629 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262883AbTFDFkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:40:11 -0400
Date: Wed, 4 Jun 2003 06:53:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "P. Benie" <pjb1008@eng.cam.ac.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
Message-ID: <20030604065336.A7755@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"P. Benie" <pjb1008@eng.cam.ac.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk>; from pjb1008@eng.cam.ac.uk on Wed, Jun 04, 2003 at 01:58:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 01:58:02AM +0100, P. Benie wrote:
> -	if (down_interruptible(&tty->atomic_write)) {
> -		return -ERESTARTSYS;
> +	if (file->f_flags & O_NONBLOCK) {
> +		if (down_trylock(&tty->atomic_write))
> +			return -EAGAIN;
> +	}
> +	else {

The else should be on the same line as the closing brace, else
the patch looks fine.

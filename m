Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTKQIaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 03:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTKQIaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 03:30:22 -0500
Received: from holomorphy.com ([199.26.172.102]:12963 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263388AbTKQIaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 03:30:20 -0500
Date: Mon, 17 Nov 2003 00:30:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031117083007.GA22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20031117054820.GT24159@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0311170745170.1089-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311170745170.1089-100000@einstein.homenet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 08:21:34AM +0000, Tigran Aivazian wrote:
> Now, since there is no way to detect EOF, other than by reading an extra 
> page and discovering that it belongs to the next iteration, we have to do 
> the lseek(fd, 0, SEEK_SET) anyway.
> So, the "auto-rewinding" read would only help the cases where application 
> doesn't need to differentiate between samples and is happy to just 
> continuously read chunks packed into pages one by one as fast as 
> possible. In this case it doesn't need to lseek to 0, so auto-rewinding on 
> kernel side would prevent it from slowing down.

If you're going to repeatedly read from 0 pread() sounds like a good
alternative to read() + lseek(), plus no kernel changes required to
get rid of the lseek().


-- wli

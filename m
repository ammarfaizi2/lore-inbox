Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSD3MqG>; Tue, 30 Apr 2002 08:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313312AbSD3MqF>; Tue, 30 Apr 2002 08:46:05 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:6661 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313307AbSD3MqF>; Tue, 30 Apr 2002 08:46:05 -0400
Date: Tue, 30 Apr 2002 13:45:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
Message-ID: <20020430134557.C26943@flint.arm.linux.org.uk>
In-Reply-To: <20020429141301.B16778@flint.arm.linux.org.uk> <3CCD672E.5040005@us.ibm.com> <3CCD811E.8689F4B0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 06:21:34PM +0100, Arjan van de Ven wrote:
> I'm not convinced of that. It's not nearly a critical path and it's
> better to get even the "dumb" drivers safe than to risk having big
> security holes in there for years to come.

Would it be worth dropping a  BUG_ON(!kernel_locked()) in tty_open() to
catch this type of error?  The tty code heavily relies on the BKL.

This way, such locking problems would get caught early, since everyone
uses the tty code during boot, right?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293700AbSCFUkY>; Wed, 6 Mar 2002 15:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293709AbSCFUkN>; Wed, 6 Mar 2002 15:40:13 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:18188 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S293700AbSCFUjz>; Wed, 6 Mar 2002 15:39:55 -0500
Date: Wed, 6 Mar 2002 20:39:36 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ed Vance <EdV@macrolink.com>
Cc: "'Roman Kurakin'" <rik@cronyx.ru>, linux-kernel@vger.kernel.org
Subject: Re: Serial.c BUG 2.4.x-2.5x
Message-ID: <20020306203936.C26344@flint.arm.linux.org.uk>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76CB@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76CB@EXCHANGE>; from EdV@macrolink.com on Fri, Mar 01, 2002 at 11:07:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 11:07:03AM -0800, Ed Vance wrote:
> On Fri, Mar 01, 2002 at 4:19 AM, Roman Kurakin wrote:
> > 
> >     Who is responsible person for applying [serial driver] patches 
> >     to main tree?

This particular bug has already been fixed in the rewrite, as I originally
said back on 14 November 2001.

The patch does fine for the most part, but I have two worries:

1. the possibilities of pushing through changes in the IO or memory space
   by changing the other space at the same time. (ie, port = 1, iomem =
   0xfe007c00 and you already have a line at port = 0, iomem = 0xfe007c00).
   I delt with this properly using the resource management subsystem.

2. there seems to be a lack of security considerations for changing the
   iomem address.  (ie, changing the iomem address without CAP_SYS_ADMIN.
   I added this as an extra check for change_port)

> I then asked Russell to set the rules for this co-ordination and no response
> has been forthcoming. Perhaps he missed my question?

I have a fair bit of email backed up at the moment, but I have been in
contact with Ted T'so recently.  I won't say much more at the moment,
but should have something in a month or two.  Until then I'd rather not
say too much publically.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


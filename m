Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284625AbRLET44>; Wed, 5 Dec 2001 14:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284624AbRLET4q>; Wed, 5 Dec 2001 14:56:46 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:57780 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S284625AbRLET4f>; Wed, 5 Dec 2001 14:56:35 -0500
Message-ID: <3C0E7CCD.F9553BBD@nortelnetworks.com>
Date: Wed, 05 Dec 2001 15:00:13 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
Cc: Cyrille Beraud <cyrille.beraud@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Removing an executable while it runs
In-Reply-To: <3C0E4487.6000704@savoirfairelinux.com> <3C0E4803.3BBF045B@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> Cyrille Beraud wrote:
> >
> > Hello,
> > I would like to remove an executable from the file-system while it is
> > running and
> > get all the blocks back immediately, not after the end of the program.
> > Is this possible ?
> >  From what I understand, the inode is not released until the program
> > ends. Do all the
> > file-systems behave the same way ?
> >
> > Thank you for your help.
> 
> It is not possible to reclaim the disk space until the program exits.
> This is because of demand paging of executables.  The file must be kept
> around to handle possible future page faults, otherwise the program
> would crash if it called code that hadn't been loaded yet or was
> discarded due to memory pressure.  This is true of all filesystems.

Couldn't you use mlockall() to ensure that demand paging is not a factor?  Then
you should be able to free up the disk space since the actual application is
guaranteed to be in ram.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135281AbRDWPLw>; Mon, 23 Apr 2001 11:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135283AbRDWPLl>; Mon, 23 Apr 2001 11:11:41 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:12181 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135281AbRDWPLc>; Mon, 23 Apr 2001 11:11:32 -0400
From: Christoph Rohland <cr@sap.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: "David L. Parsley" <parsley@linuxjedi.org>, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <3AE307AD.821AB47C@linuxjedi.org> <m3r8yjrgdc.fsf@linux.local>
	<20010423151753.C719@nightmaster.csn.tu-chemnitz.de>
Organisation: SAP LinuxLab
Date: 23 Apr 2001 16:54:02 +0200
In-Reply-To: <20010423151753.C719@nightmaster.csn.tu-chemnitz.de>
Message-ID: <m3d7a3r7jp.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Mon, 23 Apr 2001, Ingo Oeser wrote:
> On Mon, Apr 23, 2001 at 01:43:27PM +0200, Christoph Rohland wrote:
>> On Sun, 22 Apr 2001, David L. Parsley wrote:
>> > attach packages inside it.  Since symlinks in a tmpfs filesystem
>> > cost 4k each (ouch!), I'm considering using mount --bind for
>> > everything.
>> 
>> What about fixing tmpfs instead?
> 
> The question is: How? If you do it like ramfs, you cannot swap
> these symlinks and this is effectively a mlock(symlink) operation
> allowed for normal users. -> BAD!

How about storing it into the inode structure if it fits into the
fs-private union? If it is too big we allocate the page as we do it
now. The union has 192 bytes. This should be sufficient for most
cases.

Greetings
		Christoph



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSATPa4>; Sun, 20 Jan 2002 10:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288742AbSATPar>; Sun, 20 Jan 2002 10:30:47 -0500
Received: from chiark.greenend.org.uk ([212.22.195.2]:62213 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S288736AbSATPal>; Sun, 20 Jan 2002 10:30:41 -0500
X-Face: h[Hh-7npe<<b4/eW[]sat,I3O`t8A`(ej.H!F4\8|;ih)`7{@:A~/j1}gTt4e7-n*F?.Rl^
     F<\{jehn7.KrO{!7=:(@J~]<.[{>v9!1<qZY,{EJxg6?Er4Y7Ng2\Ft>Z&W?r\c.!4DXH5PWpga"ha
     +r0NzP?vnz:e/knOY)PI-
X-Boydie: NO
From: Richard Kettlewell <rjk@terraraq.org.uk>
X-Mailer: Norman
To: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
In-Reply-To: <a2bk6e$t2u$1@ncc1701.cistron.net>
	<Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu>
	<Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu>
	<8HBE1o7mw-B@khms.westfalen.de>
Date: Sun, 20 Jan 2002 15:30:39 +0000
In-Reply-To: <8HBE1o7mw-B@khms.westfalen.de> (kaih@khms.westfalen.de's
 message of "Sat, 19 Jan 2002 19:32:01 GMT")
Message-ID: <843d119h0g.fsf@rjk.greenend.org.uk>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.1 (Capitol Reef,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaih@khms.westfalen.de (Kai Henningsen) writes:
> viro@math.psu.edu (Alexander Viro) wrote:
>> On Sat, 19 Jan 2002, Miquel van Smoorenburg wrote:

>>> I now have a flink-test2.txt file. That is pretty cool ;)
>> 
>> It's also a security hole.
> 
> It may well be one when going via /proc. But is it one when going
> via a (hypothetical) proper flink(2)? If so, why?
> 
> Note that every process who has a filehandle open for reading can
> already get at the file contents and write them to a completely new
> file, and every process who has it open for writing can already
> change its contents to everything it likes. So I can see read|write
> checks on the file handle.  Also all the usual link(2) checks. What
> else could be a hole?

If the file descriptor you have was opened O_RDONLY, but you have
write permission on the file itself, then creating a new name for it
would allow you to open it O_RDWR.

I'm not 100% convinced by this argument.  If you really want a
particular user not to be able to write to a file, the certain answer
is to set its permissions appropriately, rather than rely on it having
no name.

One could make the hypothetical flink(2) only work on O_RDWR file
descriptors, or only on files owned by the euid of the calling
process.

-- 
http://www.greenend.org.uk/rjk/

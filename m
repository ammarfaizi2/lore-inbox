Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265376AbSJXKAy>; Thu, 24 Oct 2002 06:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265377AbSJXKAy>; Thu, 24 Oct 2002 06:00:54 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:15512 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265376AbSJXKAx> convert rfc822-to-8bit;
	Thu, 24 Oct 2002 06:00:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: O_DIRECT sockets? (was [RESEND] tuning linux for high network  performance?)
Date: Thu, 24 Oct 2002 12:14:59 +0200
User-Agent: KMail/1.4.1
Cc: bert hubert <ahu@ds9a.nl>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210231218.18733.roy@karlsbakk.net> <200210231726.21135.roy@karlsbakk.net> <3DB6CF9E.327E165F@us.ibm.com>
In-Reply-To: <3DB6CF9E.327E165F@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210241214.59812.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, I'm still not clear on why you cannot use sendfile()?
> I was not aware of any upper limit to the file size in order
> for sendfile() to be used?  From what little I know, this
> is exactly the kind of situation that sendfile was intended
> to benefit.

I can't use sendfile(). I'm working with files > 4GB, and from man 2 sendfile:

ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count);

int main() {
	ssize_t s1;
	off_t offset;
	size_t count;

	printf("sizeof ssize_t: %d\n", sizeof s1);
	printf("sizeof size_t: %d\n", sizeof count);
	printf("sizeof off_t: %d\n", sizeof offset);
	return 0;
}

running it

$ ./sendfile_test
sizeof ssize_t: 4
sizeof size_t: 4
sizeof off_t: 4
$ 

as far as I'm concerned, this will not allow me to address files past the 4GB 
limit (or was it 2?)

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.


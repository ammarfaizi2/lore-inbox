Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbSBKAOM>; Sun, 10 Feb 2002 19:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSBKAOC>; Sun, 10 Feb 2002 19:14:02 -0500
Received: from flrtn-4-m1-156.vnnyca.adelphia.net ([24.55.69.156]:38287 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S285338AbSBKANu>;
	Sun, 10 Feb 2002 19:13:50 -0500
Message-ID: <3C670CB4.7000005@tmsusa.com>
Date: Sun, 10 Feb 2002 16:13:40 -0800
From: J Sloan <joe@tmsusa.com>
Organization: J S Concepts
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: TUN/TAP driver doesn't work.
In-Reply-To: <Pine.NEB.4.33.0202101644050.21436-100000@courage.cs.stevens-tech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This program compiles and works here. I'm using
RH 7.2, but the vtund setup hasn't changed from
my RH 7.1 setup.

Have you successfully installed vtund and tun?

Make sure your kernel-headers package is newer
than 2.4.7 - maybe grab the rawhide kernel headers
package which is IIRC 2.4.17 -

The old kernel headers package (2.4.2) won't work
or allow compiling of current version of vtund.

Joe

Marek Zawadzki wrote:

>Hello,
>
>I am trying to use TUN/TAP driver. My OS is RH71, kernel is 2.4.17, with
>tuntap compiled as a module. Module is inserted properly when I try to
>open '/dev/net/tun', and I get kernel message saying "TUN/TAP universal
>driver, (c)...etc.". But ioctls don't work and always return '-1'.
>To test it I was using code from tuntap's documentation (included below this
>message and btw I don't understand dev's name str-copying in this code)
>and pengaol, newest version, which I know works with tuntap. None of these
>2 programs work for me.
>
>Any help would be really greatly appreciated.
>
>-marek
>
>-- test code --
>#include        <sys/fcntl.h>
>#include        <sys/ioctl.h>
>#include        <net/if.h>
>#include        <linux/if_tun.h>
>
>int tun_alloc(char *dev)
>{
>    struct ifreq ifr;
>    int fd, err;
>
>    if( (fd = open("/dev/net/tun", O_RDWR)) < 0 ) {
>       printf("open error\n");
>   	 return 0;
>    }
>
>    memset(&ifr, 0, sizeof(ifr));
>
>    /* Flags: IFF_TUN   - TUN device (no Ethernet headers)
>     *        IFF_TAP   - TAP device
>     *        IFF_NO_PI - Do not provide packet information
>     *
>     */
>    ifr.ifr_flags = IFF_TUN;
>
>    if( *dev )
>        strncpy(ifr.ifr_name, dev, IFNAMSIZ);
>
>    if( (err = ioctl(fd, TUNSETIFF, (void *) &ifr)) < 0 ){
>        printf("ioctl err %d: %s\n", err, strerror(err));
>        close(fd);
>        return err;
>    }
>    strcpy(dev, ifr.ifr_name);
>    return fd;
>}
>
>int main(int argc, char **argv)
>{
>	char test[100] = "1234567890123456";
>	tun_alloc(test);
>	return 0;
>}
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



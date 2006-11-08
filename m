Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423165AbWKHUcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423165AbWKHUcI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423251AbWKHUcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:32:07 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5556 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423165AbWKHUcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:32:03 -0500
Subject: [TEST SUITE] termios: basic test set for the new termios code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-serial@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 20:36:46 +0000
Message-Id: <1163018206.23956.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please send any updates/extra test cases to me.

/*
 *	Test suite for the new termios functions
 *
 *	gcc -iquote kernel-src/include/asm-x86_64 test-suite.c -o ./ts
 */
 
#include "termbits.h"
#include "termios.h"
#include "ioctls.h"

#define TCGETS2         _IOR('T',0x2A, struct termios2)
#define TCSETS2         _IOW('T',0x2B, struct termios2)
#define TCSETSW2        _IOW('T',0x2C, struct termios2)
#define TCSETSF2        _IOW('T',0x2D, struct termios2)

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>

static int compare_termios_11(struct termios *a, struct termios *b)
{
  int diff = 0;
  
  if(a->c_iflag != b->c_iflag) {
    printf("Iflag change of %04X\n", a->c_iflag ^ b->c_iflag);
    diff = 1;
  }
  if(a->c_oflag != b->c_oflag) {
    printf("Oflag change of %04X\n", a->c_oflag ^ b->c_oflag);
    diff = 1;
  }
  if(a->c_cflag != b->c_cflag) {
    printf("Iflag change of %04X\n", a->c_cflag ^ b->c_cflag);
    diff = 1;
  }
  if(a->c_lflag != b->c_lflag) {
    printf("Iflag change of %04X\n", a->c_lflag ^ b->c_lflag);
    diff = 1;
  }
  if(a->c_line != b->c_line) {
    printf("Line differs %02X v %02X\n", a->c_line, b->c_line);
    diff = 1;
  }
#ifdef NCC_V1  
  if(memcmp(a->c_cc, b->c_cc, NCC_V1)) {
#else
  if(memcmp(a->c_cc, b->c_cc, NCC)) {
#endif  
    printf("CC differs.\n");
    diff = 1;
  }
  return diff;
}

static int compare_termios_12(struct termios *a, struct termios2 *b)
{
  int diff = 0;
  
  if(a->c_iflag != b->c_iflag) {
    printf("Iflag change of %04X\n", a->c_iflag ^ b->c_iflag);
    diff = 1;
  }
  if(a->c_oflag != b->c_oflag) {
    printf("Oflag change of %04X\n", a->c_oflag ^ b->c_oflag);
    diff = 1;
  }
  if(a->c_cflag != b->c_cflag) {
    printf("Iflag change of %04X\n", a->c_cflag ^ b->c_cflag);
    diff = 1;
  }
  if(a->c_lflag != b->c_lflag) {
    printf("Iflag change of %04X\n", a->c_lflag ^ b->c_lflag);
    diff = 1;
  }
  if(a->c_line != b->c_line) {
    printf("Line differs %02X v %02X\n", a->c_line, b->c_line);
    diff = 1;
  }
#ifdef NCC_V1  
  if(memcmp(a->c_cc, b->c_cc, NCC_V1)) {
#else
  if(memcmp(a->c_cc, b->c_cc, NCC)) {
#endif  
    printf("CC differs.\n");
    diff = 1;
  }
  return diff;
}

static int compare_termios_22(struct termios2 *a, struct termios2 *b)
{
  int diff = 0;
  
  if(a->c_iflag != b->c_iflag) {
    printf("Iflag change of %04X\n", a->c_iflag ^ b->c_iflag);
    diff = 1;
  }
  if(a->c_oflag != b->c_oflag) {
    printf("Oflag change of %04X\n", a->c_oflag ^ b->c_oflag);
    diff = 1;
  }
  if(a->c_cflag != b->c_cflag) {
    printf("Iflag change of %04X\n", a->c_cflag ^ b->c_cflag);
    diff = 1;
  }
  if(a->c_lflag != b->c_lflag) {
    printf("Iflag change of %04X\n", a->c_lflag ^ b->c_lflag);
    diff = 1;
  }
  if(a->c_line != b->c_line) {
    printf("Line differs %02X v %02X\n", a->c_line, b->c_line);
    diff = 1;
  }
  if(memcmp(a->c_cc, b->c_cc, NCC)) {
    printf("CC differs.\n");
    diff = 1;
  }
  if(a->c_ispeed != b->c_ispeed) {
    printf("Ispeed differs %d v %d\n", a->c_ispeed, b->c_ispeed);
    diff = 1;
  }
  if(a->c_ospeed != b->c_ospeed) {
    printf("Ospeed differs %d v %d\n", a->c_ospeed, b->c_ospeed);
    diff = 1;
  }
  return diff;
}


struct padcheck1
{
  struct termios a;
  unsigned int cookie;
};

struct padcheck2
{
  struct termios2 a;
  unsigned int cookie;
};


static void do_check_no_overrun(int fd, unsigned int cookie)
{
  static struct padcheck1 t1;
  static struct padcheck2 t2;

  t1.cookie = cookie;
  t2.cookie = cookie;
  t2.a.c_ospeed = cookie;
  
  if(ioctl(fd, TCGETS, &t1) < 0) {
    perror("ioctl");
    exit(1);
  }
  
  if(t1.cookie != cookie) {
   printf("FAIL: TCGETS scribbled on cookie.\n");
    exit(1);
  }

  if(ioctl(fd, TCGETS2, &t2) < 0) {
    perror("ioctl");
    fprintf(stderr, "This kernel does not appear to support extended termios.\n");
    exit(1);
  }
  
  if(t2.cookie != cookie) {
   printf("FAIL: TCGETS2 scribbled on cookie.\n");
    exit(1);
  }
  
  if(t2.a.c_ospeed == cookie) {
    printf("FAIL: TCGETS2 read appears short.\n");
    exit(1);
  }
  
  if(compare_termios_12(&t1.a, &t2.a)) {
    printf("FAIL: TCGETS and TCGETS2 disagree on common data.\n");
    exit(1);
  }
  printf("PASS: Basic scribble test.\n");
}

static void test_functions(int fd)
{
  struct termios2 t1;
  struct termios2 t2;
  struct termios t1_v1;
  
  if(ioctl(fd, TCGETS2, &t1) < 0) {
    perror("ioctl");
    exit(1);
  }
  printf("Initial ospeed %d\n", t1.c_ospeed);
  t1.c_ospeed = 12345;
  t1.c_cflag &= ~CBAUD;
  t1.c_cflag |= BOTHER;
  
  if(ioctl(fd, TCSETS2, &t1) < 0) {
    perror("ioctl");
    printf("FAIL: unsupported speed should not error\n");
    exit(1);
  }
  
  /* Get the actual values set: May differ */
  if(ioctl(fd, TCGETS2, &t2) < 0) {
    perror("ioctl");
    exit(1);
  }
  
  /* May be differences to report but are ok */
  compare_termios_22(&t1, &t2);
  
  if(ioctl(fd, TCGETS2, &t1) < 0) {
    perror("ioctl");
    exit(1);
  }

  if(compare_termios_22(&t1, &t2)) {
    printf("FAIL: Repeating TCGETS gives different result.\n");
    exit(1);
  }

  if(ioctl(fd, TCGETS, &t1_v1) < 0) {
    perror("ioctl");
    exit(1);
  }

  if(compare_termios_12(&t1_v1, &t2)) {
    printf("FAIL: Repeating TCGETS in old form gives different result.\n");
    exit(1);
  }

  if(ioctl(fd, TCSETS2, &t1) < 0) {
    perror("ioctl");
    printf("FAIL: settings provided by terminal should not fail on set.\n");
    exit(1);
  }

  if(ioctl(fd, TCGETS, &t1_v1) < 0) {
    perror("ioctl");
    exit(1);
  }

  if(ioctl(fd, TCGETS2, &t2) < 0) {
    perror("ioctl");
    exit(1);
  }

  /* Differences are bad because this is using the settings the tty said were ok */  
  if (compare_termios_22(&t1, &t2)) {
    printf("FAIL: fetched settings differ from set ones yet were tty provided.\n");
    exit(1);
  }  

  if (compare_termios_12(&t1_v1, &t1)) {
    printf("FAIL: old ioctl settings differ from set ones yet were tty provided and new setting agreed.\n");
    exit(1);
  }  

  if(t1.c_ospeed != 12345) {
    printf("SKIP: Tests that may need a pty.\n");
    return;
  }
  
  if(t1_v1.c_cflag & BOTHER)
    printf("t1_v1 BOTHER - OK");
  /* Now see what occurs if we set an old style and get new style, speed should
     be preserved. */
     
  if(ioctl(fd, TCSETS, &t1_v1) < 0) {
    perror("ioctl");
    exit(1);
  }
  
  if(ioctl(fd, TCGETS2, &t2) < 0) {
    perror("ioctl");
    exit(1);
  }
  
  if(t2.c_ospeed != 12345) {
    printf("FAIL: setting old style termios disturbed extended speed.\n");
    printf("SPEED: %d\n", t2.c_ospeed);
    exit(1);
  }
  
  /* Now try the reverse */
  
  t1_v1.c_cflag &= ~CBAUD;
  t1_v1.c_cflag |= B9600;
  
  if(ioctl(fd, TCSETS, &t1_v1) < 0) {
    perror("ioctl");
    exit(1);
  }
  
  if(ioctl(fd, TCGETS2, &t2) < 0) {
    perror("ioctl");
    exit(1);
  }
  
  if(t2.c_ospeed != 9600) {
    printf("FAIL: speed was not reset by old style termios set.\n");
    exit(1);
  }
  
}


int main(int argc, char *argv[])
{
  int fd;
  if(argc != 2) {
    fprintf(stderr, "%s: [ttypath].\n", argv[0]);
    exit(1);
  }
  
  fd = open(argv[1], O_RDWR);
  if(fd == -1) {
    perror(argv[1]);
    exit(1);
  }
  
  do_check_no_overrun(fd, 0xA5A5A5A5);
  do_check_no_overrun(fd, 0x5A5A5A5A);
  test_functions(fd);
  
  printf("PASS\n");
  exit(0);
}


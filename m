Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280837AbRKONut>; Thu, 15 Nov 2001 08:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280838AbRKONuk>; Thu, 15 Nov 2001 08:50:40 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:13987 "EHLO
	c0mailgw12.prontomail.com") by vger.kernel.org with ESMTP
	id <S280837AbRKONu0>; Thu, 15 Nov 2001 08:50:26 -0500
Message-ID: <3BF3C804.5C93D34@starband.net>
Date: Thu, 15 Nov 2001 08:49:56 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System Locks Temporarily When Untarring Large Files
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem to report:
- I often decompress tar files which are several hundred megabytes big.
- With newer 2.4.x kernels (2.4.10-14), when I am decompressing a large
tar file, my X session locks up for about 20-30 seconds.
- With Kernel 2.4.3, I do not recall X locking up when dealing with
large files.

1) Could one of my paramters for the /proc be causing this?
2) I got the basic lines from "Optimizing and Securing RedHat Linux..."
and customized them for my machine.
3) Where did /proc/sys/vm/buffermem go from earlier 2.4.x kernels? What
has it been replaced with?


1) Here is what I use to optimize the system.

#!/bin/sh

check()
{
if [ "`whoami`" != "root" ]
then
  echo "You must be root to use this program."
  exit
fi
}

filesystem()
{
echo "Improving Overall Performance..."
echo "Improving filesystem (swap) performance ................. [
ENABLED ]"
echo "100 1200 128 512 15 5000 500 1884 2" > /proc/sys/vm/bdflush
#echo "Optimizing buffermem for a 1024MB configuration ......... [
ENABLED ]" # for earlier 2.4.x kernels
#echo "80 10 60" > /proc/sys/vm/buffermem
echo "Optimizing the file-max for a 1024MB configuration ...... [
ENABLED ]"
echo "65536" > /proc/sys/fs/file-max
}

network()
{
echo "Securing network settings..."

echo "Enable ICMP Pings ....................................... [
ENABLED ]"
echo "0" > /proc/sys/net/ipv4/icmp_echo_ignore_all

echo "Disable Broadcast ICMP Packets .......................... [
ENABLED ]"
echo "1" > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts

echo "Disable Source IP Routing ............................... [
ENABLED ]"
for i in /proc/sys/net/ipv4/conf/*/accept_source_route
do
  echo "0" > $i
done

echo "Enabling SYN Cookies .................................... [
ENABLED ]"
echo "1" > /proc/sys/net/ipv4/tcp_syncookies

echo "Enabling ICMP ignore on bogus error responses ........... [
ENABLED ]"
echo "1" > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses

echo "Enabling IP Spoofing Protection ......................... [
ENABLED ]"
for i in /proc/sys/net/ipv4/conf/*/rp_filter
do
  echo "1" > $i
done

echo "Enabling Logging Of Spoofed Packets ..................... [
ENABLED ]"
for i in /proc/sys/net/ipv4/conf/*/log_martians
do
  echo "1" > $i
done

echo "Increasing Additional Port Usage ........................ [
ENABLED ]"
echo "32768 61000" > /proc/sys/net/ipv4/ip_local_port_range

echo "Increasing General TCP/IP Throughput .................... [
ENABLED ]"
echo "30" > /proc/sys/net/ipv4/tcp_fin_timeout
echo "1800" > /proc/sys/net/ipv4/tcp_keepalive_time
echo "0" > /proc/sys/net/ipv4/tcp_window_scaling
echo "0" > /proc/sys/net/ipv4/tcp_sack
echo "0" > /proc/sys/net/ipv4/tcp_timestamps

echo "Setting keepalive time to 4 months ...................... [
ENABLED ]"
echo "12157520" > /proc/sys/net/ipv4/tcp_keepalive_time

}

main()
{
check
filesystem
network
}

main

2) My system specifications are as follows:

System Hardware:
    CPU Type: Pentium III
   CPU Speed: 868.665 MHz
         Ram: 1005 MB
        Swap: 2000 MB

System Software:
Distribution: Red Hat Linux release 7.2 (Enigma)
    autoconf: 2.52
     autogen: 5.2.11
    automake: 1.5
    binutils: 2.11.2
      esound: 0.2.22
         gcc: 2.95.3
     gettext: 0.10.40
       glibc: 2.2.4
        glib: 1.2.10
  gnome-libs: 1.2.13
         gtk: 1.2.10
       imlib: 1.9.11
     kdelibs: 2.2.1
      kernel: 2.4.14
     libtool: 1.4.1
     openssl: 0.9.6b
       orbit: 0.5.8
   orbit-idl: 0.6.8
        perl: 5.6.1
          qt: 3.0.0
         rpm: 4.0.3
         sdl: 1.2.2
     xfree86: 4.1.0
        xml2: 2.4.10
         xml: 1.8.16




